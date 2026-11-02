"""Prepare an OCI Sandbox and connect it to an OpenAI agent session."""
import json
import os
import time
import uuid
from pathlib import Path

import oci
from openai import APIConnectionError, APIStatusError, OpenAI, Stream
from oci.generative_ai_sandbox import GenerativeAiSandboxClient
from oci.generative_ai_sandbox.models import (
    CreateSandboxDetails, EnvironmentVariable, RunSandboxCommandDetails)
from cloud_auth import signer
from sandbox_access import wait_for

ROOT = Path(__file__).resolve().parent
STATE = ROOT / 'agent-state.json'
JSON = dict[str, object]
MODEL = 'gpt-6-luna'
EXECUTOR = '/workspace/.executor/node_modules/.bin/codex'


def save(state):
    temporary = STATE.with_suffix('.tmp')
    temporary.write_text(json.dumps(state, indent=2) + '\n')
    temporary.replace(STATE)


def retry_token(state, name):
    state.setdefault(name, str(uuid.uuid4()))
    save(state)
    return state[name]


def poll(fetch, ready, seconds=180):
    deadline = time.monotonic() + seconds
    while time.monotonic() < deadline:
        value = fetch()
        if ready(value):
            return value
        time.sleep(2)
    raise RuntimeError('Timed out waiting for readiness. Keep agent-state.json and rerun to resume.')


def prepare_sandbox(client, config, state):
    if not state.get('sandbox_id'):
        sandbox = client.create_sandbox(config['project_id'], CreateSandboxDetails(
            display_name='workshop-agent', runtime='python-3.11',
            shape='SMALL', expiration_duration='PT60M'),
            opc_retry_token=retry_token(state, 'sandbox_token')).data
        state['sandbox_id'] = sandbox.id
        save(state)
    wait_for(client, state['sandbox_id'], 'RUNNING')
    with (ROOT / 'monthly-financials.csv').open('rb') as data:
        client.write_sandbox_file(state['sandbox_id'], '/workspace/monthly-financials.csv', data)
    print('Sandbox: RUNNING')


def install_executor(client, state):
    if state.get('installed'):
        return
    if not state.get('install_command_id'):
        command = client.run_sandbox_command(state['sandbox_id'], RunSandboxCommandDetails(
            command='sh', args=['-lc', 'npm install --prefix /workspace/.executor '
                '--cache /workspace/.npm-cache --no-audit --no-fund @openai/codex@alpha '
                f'&& {EXECUTOR} exec-server --help >/dev/null'], timeout='PT5M'),
            opc_retry_token=retry_token(state, 'install_token')).data
        state['install_command_id'] = command.id
        save(state)
    output = poll(lambda: client.get_sandbox_command_output(
        state['sandbox_id'], state['install_command_id']).data,
        lambda value: value.exit_code is not None, seconds=330)
    if output.exit_code != 0:
        state.pop('install_command_id')
        state.pop('install_token')
        save(state)
        raise RuntimeError('Executor installation failed. Check registry.npmjs.org on port 443 and rerun.')
    state['installed'] = True
    save(state)
    print('Executor: INSTALLED')


def create_session(api, state):
    if state.get('session_id'):
        return api.get(f"/agents/sessions/{state['session_id']}", cast_to=JSON)
    if state.get('session_requested'):
        raise RuntimeError('Session creation outcome is unknown. Check the OpenAI Agents dashboard '
                           'before retrying; retain agent-state.json to avoid creating duplicates.')
    state['session_requested'] = True
    save(state)
    return api.post(
        '/agents/sessions',
        cast_to=JSON,
        body={
            'agent': {
                'model': MODEL,
                'instructions': (
                    'Analyze the supplied CSV '
                    'using Python in /workspace. '
                    'Use actual execution results.'
                ),
            },
            'environment': {
                'type': 'self_hosted',
                'workspace_directory': '/workspace',
            },
        },
    )


def remember_session(api, state):
    try:
        session = create_session(api, state)
    except APIStatusError as error:
        if 400 <= error.status_code < 500:
            state.pop('session_requested', None)
            save(state)
        raise
    state.update(session_id=session['id'], environment_id=session['environment']['id'])
    save(state)
    return session


def start_executor(client, state, environment, environment_key):
    if state.get('executor_command_id'):
        return
    arguments = [
        'exec-server',
        '--remote', environment['remote_url'],
        '--environment-id', environment['id'],
    ]
    command = client.run_sandbox_command(
        state['sandbox_id'],
        RunSandboxCommandDetails(
            command=EXECUTOR,
            args=arguments,
            cwd='/workspace',
            timeout='PT60M',
            environment_variables=[
                EnvironmentVariable(
                    name='CODEX_API_KEY',
                    value=environment_key,
                ),
            ],
        ),
        opc_retry_token=retry_token(state, 'executor_token'),
    ).data
    state['executor_command_id'] = command.id
    save(state)


def connection_ready(environment):
    if environment['status'] == 'failed':
        raise RuntimeError('OpenAI reports a failed environment connection. Check the key ownership '
                           'and outbound rules, then inspect the session in the OpenAI Agents dashboard.')
    return environment['status'] == 'connected'


def connect(api, client, state, session, environment_key):
    with api.get(f"/agents/sessions/{session['id']}/events?stream=true",
                 cast_to=JSON, stream=True, stream_cls=Stream[JSON]):
        start_executor(client, state, session['environment'], environment_key)
        poll(lambda: api.get(f"/agents/environments/{state['environment_id']}", cast_to=JSON),
             connection_ready)
    print('Agent connection: CONNECTED')
    print('Ready for the analysis.')


def main():
    application_key = os.environ['OPENAI_API_KEY']
    environment_key = os.environ['OPENAI_EXECUTOR_API_KEY']
    config = json.loads((ROOT / 'config.json').read_text())
    state = json.loads(STATE.read_text()) if STATE.exists() else {}
    client = GenerativeAiSandboxClient({'region': config['region']}, signer=signer(), timeout=(10, 60))
    with OpenAI(api_key=application_key, base_url='https://api.openai.com/v1',
                default_headers={'OpenAI-Beta': 'agents=v1'}, timeout=60, max_retries=0) as api:
        session = remember_session(api, state)
        prepare_sandbox(client, config, state)
        install_executor(client, state)
        connect(api, client, state, session, environment_key)
    print(f'Resource identifiers saved to {STATE.name}.')


if __name__ == '__main__':
    try:
        main()
    except KeyError as error:
        if error.args[0] in ('OPENAI_API_KEY', 'OPENAI_EXECUTOR_API_KEY'):
            raise SystemExit('Set both keys using Task 1 before running this script.')
        raise
    except FileNotFoundError as error:
        raise SystemExit(f'Missing {Path(error.filename).name}. Use the complete workshop ZIP and finish Lab 1.')
    except APIStatusError as error:
        raise SystemExit(f'OpenAI request failed: HTTP {error.status_code}. Check key permissions and Agents API access.')
    except oci.exceptions.ServiceError as error:
        raise SystemExit(f'OCI request failed: HTTP {error.status}. Check project status and Sandbox permissions.')
    except (APIConnectionError, oci.exceptions.RequestException):
        raise SystemExit('Cloud Shell could not reach a service. Check Public network; keep agent-state.json before retrying.')
    except (RuntimeError, oci.exceptions.MaximumWaitTimeExceeded) as error:
        raise SystemExit(str(error))

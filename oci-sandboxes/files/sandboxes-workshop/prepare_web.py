"""Start the financial report application in a separate OCI Sandbox."""
import argparse
import json
import uuid
from pathlib import Path

import oci
from oci.generative_ai_sandbox import GenerativeAiSandboxClient
from oci.generative_ai_sandbox.models import CreateSandboxDetails, RunSandboxCommandDetails
from cloud_auth import signer
from sandbox_access import wait_for

ROOT = Path(__file__).resolve().parent
STATE = ROOT / 'web-state.json'


def save(state):
    temporary = STATE.with_suffix('.tmp')
    temporary.write_text(json.dumps(state, indent=2) + '\n')
    temporary.replace(STATE)


def create(client, config, state):
    if not state.get('sandbox_id'):
        state.setdefault('create_token', str(uuid.uuid4()))
        save(state)
        sandbox = client.create_sandbox(
            config['project_id'],
            CreateSandboxDetails(
                display_name='workshop-web',
                runtime='python-3.11',
                shape='SMALL',
                expiration_duration='PT60M',
                publish_ports=['8080'],
            ),
            opc_retry_token=state['create_token'],
        ).data
        state['sandbox_id'] = sandbox.id
        save(state)
    wait_for(client, state['sandbox_id'], 'RUNNING')
    for name in ('web_app.py', 'monthly-financials.csv'):
        with (ROOT / name).open('rb') as data:
            client.write_sandbox_file(state['sandbox_id'], f'/workspace/{name}', data)
    print('Sandbox: RUNNING')


def start(client, state):
    if not state.get('command_id'):
        state.setdefault('start_token', str(uuid.uuid4()))
        save(state)
        command = client.run_sandbox_command(
            state['sandbox_id'],
            RunSandboxCommandDetails(
                command='python',
                args=['/workspace/web_app.py'],
                timeout='PT60M',
            ),
            opc_retry_token=state['start_token'],
        ).data
        state['command_id'] = command.id
        save(state)


def check(client, state):
    probe = (
        'import time, urllib.request\n'
        'for attempt in range(10):\n'
        ' try:\n'
        '  with urllib.request.urlopen("http://127.0.0.1:8080/", timeout=2) as r:\n'
        '   assert r.status == 200\n'
        '   print("Application: READY (port 8080)")\n'
        '   break\n'
        ' except OSError:\n'
        '  if attempt == 9: raise\n'
        '  time.sleep(1)\n'
    )
    output = client.run_sandbox_command_and_wait(
        state['sandbox_id'],
        RunSandboxCommandDetails(command='python', args=['-c', probe], timeout='PT30S'),
        retry_strategy=oci.retry.NoneRetryStrategy(),
    ).data.output
    if output.exit_code != 0:
        raise RuntimeError(output.stderr or 'The application did not respond on port 8080.')
    print(output.stdout or '', end='')


def show_access(client, state):
    sandbox = client.get_sandbox(state['sandbox_id']).data
    port = next((port for port in sandbox.published_ports or [] if port.key == '8080'), None)
    if port is None:
        raise RuntimeError('Port 8080 was not published when this sandbox was created.')
    print('Published port: 8080')
    print(f'Authentication: {sandbox.published_port_auth_mode or "None"}')
    print(f'Application URL: {port.value}')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('action', nargs='?', choices=['start', 'access'], default='start')
    args = parser.parse_args()
    config = json.loads((ROOT / 'config.json').read_text())
    state = json.loads(STATE.read_text()) if STATE.exists() else {}
    client = GenerativeAiSandboxClient({'region': config['region']}, signer=signer())
    if args.action == 'access':
        if not state.get('sandbox_id'):
            raise RuntimeError('Run python prepare_web.py first.')
        show_access(client, state)
        return
    create(client, config, state)
    start(client, state)
    check(client, state)


if __name__ == '__main__':
    try:
        main()
    except FileNotFoundError as error:
        raise SystemExit(f'Missing {Path(error.filename).name}. Complete Lab 1 and use the current workshop ZIP.')
    except oci.exceptions.ServiceError as error:
        raise SystemExit(f'OCI request failed: HTTP {error.status} ({error.code}). {error.message}')
    except oci.exceptions.RequestException:
        raise SystemExit('Cloud Shell could not reach OCI. Check Public network and rerun.')
    except oci.exceptions.MaximumWaitTimeExceeded:
        raise SystemExit('The sandbox is still changing state. Rerun the script to continue.')
    except RuntimeError as error:
        raise SystemExit(str(error))

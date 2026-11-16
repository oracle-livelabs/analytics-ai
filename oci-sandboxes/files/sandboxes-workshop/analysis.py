"""Generate analysis code, run it in an OCI Sandbox, and explain the results."""
import argparse
import json
from pathlib import Path

import httpx
import oci
from openai import APIConnectionError, APIStatusError, OpenAI
from oci.generative_ai_sandbox import GenerativeAiSandboxClient
from cloud_auth import CloudShellAuth, signer
from sandbox_access import run_script

ROOT = Path(__file__).resolve().parent
MODEL = 'openai.gpt-oss-120b'
CODE = ROOT / 'generated-analysis.py'
STATE = ROOT / 'analysis-state.json'
RESULT = ROOT / 'analysis-result.json'
QUESTION = 'Which products have the largest profit shortfall, and what is the total shortfall?'
INSTRUCTIONS = """Use run_python once to calculate the answer from /workspace/monthly-financials.csv.
CSV columns: month, product, budget_revenue, actual_revenue, budget_cogs,
actual_cogs, budget_freight, actual_freight. Amounts are integer USD.
Profit = revenue - cogs - freight. Shortfall = budget_profit - actual_profit.
Include every product. Use only Python's csv, json and pathlib modules.
Write /workspace/analysis-result.json with this structure and print the same JSON:
{"products": [{"product": "name", "budget_profit": 0, "actual_profit": 0,
"shortfall": 0}], "total_shortfall": 0}.
Read only the supplied CSV. Do not use the network, access credentials or install packages.
Use the execution result to answer; do not invent figures."""
TOOL = {
    'type': 'function', 'name': 'run_python',
    'description': 'Execute Python code in the workshop OCI Sandbox.',
    'parameters': {'type': 'object', 'properties': {'code': {'type': 'string'}},
                   'required': ['code'], 'additionalProperties': False},
    'strict': True,
}


def responses_client(config):
    region = config['region']
    return OpenAI(
        base_url=f"https://inference.generativeai.{region}.oci.oraclecloud.com/openai/v1",
        api_key='not-used', project=config['project_id'],
        http_client=httpx.Client(auth=CloudShellAuth()), timeout=120, max_retries=0)


def request_code(api):
    conversation = api.conversations.create()
    response = api.responses.create(
        model=MODEL,
        input=QUESTION,
        conversation=conversation.id,
        instructions=INSTRUCTIONS,
        tools=[TOOL],
        tool_choice='required',
        parallel_tool_calls=False,
        max_output_tokens=4000,
    )
    call = next((item for item in response.output if item.type == 'function_call'), None)
    if response.status != 'completed' or call is None or call.name != 'run_python':
        raise RuntimeError('Code generation did not complete. Rerun the generate action.')
    return conversation.id, call


def generate(config):
    with responses_client(config) as api:
        conversation_id, call = request_code(api)
    CODE.write_text(json.loads(call.arguments)['code'])
    STATE.write_text(json.dumps({'conversation_id': conversation_id, 'call_id': call.call_id}, indent=2))
    RESULT.unlink(missing_ok=True)
    print(f'Request: {QUESTION}')
    print(f'Code saved to {CODE.name}.')


def run_code(client, sandbox_id):
    RESULT.unlink(missing_ok=True)
    output = run_script(client, sandbox_id, CODE)
    if output.exit_code != 0:
        raise RuntimeError('Analysis failed. Resolve the error above before continuing.')


def run(config):
    client = GenerativeAiSandboxClient({'region': config['region']}, signer=signer(), timeout=(10, 60))
    run_code(client, config['sandbox_id'])
    response = client.read_sandbox_file(
        config['sandbox_id'],
        '/workspace/analysis-result.json',
    )
    result = json.loads(response.data.content)
    RESULT.write_text(json.dumps(result, indent=2) + '\n')
    print(f'Result saved to {RESULT.name}.')


def explain(config):
    state = json.loads(STATE.read_text())
    tool_output = {
        'type': 'function_call_output',
        'call_id': state['call_id'],
        'output': RESULT.read_text(),
    }
    with responses_client(config) as api:
        response = api.responses.create(
            model=MODEL,
            input=[tool_output],
            conversation=state['conversation_id'],
            tools=[TOOL],
            tool_choice='none',
            max_output_tokens=2000,
            instructions=(
                'Answer the original question '
                'using the tool result. Include ties '
                'and the total shortfall in USD.'
            ),
        )
    if (
        response.status != 'completed'
        or not response.output_text.strip()
    ):
        raise RuntimeError(
            'The explanation did not complete. '
            'Rerun the explain action.'
        )
    print(response.output_text)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('action', choices=['generate', 'run', 'explain'])
    args = parser.parse_args()
    config = json.loads((ROOT / 'config.json').read_text())
    {'generate': generate, 'run': run, 'explain': explain}[args.action](config)


if __name__ == '__main__':
    try:
        main()
    except FileNotFoundError as error:
        raise SystemExit(f'Missing {Path(error.filename).name}. Complete the preceding lab steps first.')
    except (APIStatusError, oci.exceptions.ServiceError) as error:
        status = error.status_code if isinstance(error, APIStatusError) else error.status
        raise SystemExit(f'OCI request failed: HTTP {status}. Check the saved region, IAM permissions and resource status.')
    except (APIConnectionError, oci.exceptions.RequestException):
        raise SystemExit('Could not reach OCI. Check Cloud Shell Public network and retry.')
    except (RuntimeError, ValueError) as error:
        raise SystemExit(str(error))

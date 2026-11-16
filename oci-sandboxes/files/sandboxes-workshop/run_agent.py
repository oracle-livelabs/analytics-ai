"""Ask the connected agent to analyze the sample financial data."""
import json
import os
import uuid

import httpx
from openai import APIConnectionError, APIError, APIStatusError, OpenAI, Stream
from prepare_agent import JSON, ROOT, STATE, save

PROMPT = """Read /workspace/monthly-financials.csv and calculate profit and shortfall.
Profit = revenue - cogs - freight. Shortfall = budget_profit - actual_profit.
Print budget profit, actual profit and shortfall by product and in total, in USD.
Return only the results table and a brief conclusion identifying the largest
product shortfall (including ties) and the total shortfall.
Use Python's standard library. Read only the supplied CSV; do not access credentials,
use the network or install packages."""
ANSWER = ROOT / 'agent-answer.md'
ITEMS = ROOT / 'agent-items.json'


def submit(api, session_path, request):
    api.post(
        f'{session_path}/events',
        cast_to=JSON,
        options={
            'headers': {
                'Idempotency-Key': request['key'],
            },
        },
        body={
            'events': [{
                'type': 'agent.session.input.message',
                'input': [{
                    'role': 'user',
                    'content': [{
                        'type': 'input_text',
                        'text': request['prompt'],
                    }],
                }],
            }],
        },
    )


def completed_turn(turn):
    if turn['status'] in ('failed', 'cancelled'):
        code = (turn.get('error') or {}).get('code', turn['status'])
        raise RuntimeError(f'Analysis: {turn["status"].upper()} ({code}). '
                           'Inspect the session in the OpenAI Agents dashboard before retrying.')
    return turn['id'] if turn['status'] == 'completed' else None


def wait_for_answer(api, session_path, state):
    request = state['analysis']
    with api.get(f'{session_path}/events?stream=true', cast_to=JSON,
                 stream=True, stream_cls=Stream[JSON]) as events:
        if not request.get('submitted'):
            submit(api, session_path, request)
            request['submitted'] = True
            save(state)
        turns = api.get(f'{session_path}/turns', cast_to=JSON,
                        options={'params': {'order': 'asc', 'limit': 100}})['data']
        root_turn = next((turn for turn in turns if not turn.get('subagent_id')), None)
        if root_turn and (turn_id := completed_turn(root_turn)):
            return turn_id
        print('Analysis: RUNNING', flush=True)
        for event in events:
            turn = event.get('turn')
            if turn and not turn.get('subagent_id'):
                if turn_id := completed_turn(turn):
                    return turn_id
            if event['type'] in ('error', 'agent.session.failed',
                                  'agent.session.environment.failed', 'agent.session.requires_action'):
                raise RuntimeError('The agent needs attention. Inspect the session in the '
                                   'OpenAI Agents dashboard and check the Task 2 connection.')
    raise RuntimeError('Connection closed before completion. Rerun this script to retrieve or resume the analysis.')


def read_items(api, session_path, turn_id):
    items = []
    params = {'order': 'asc', 'limit': 100}
    while True:
        page = api.get(f'{session_path}/items', cast_to=JSON, options={'params': params})
        items.extend(item for item in page['data'] if item['turn_id'] == turn_id)
        if not page['has_more']:
            return items
        params['after'] = page['last_id']


def redact(text):
    for name in ('OPENAI_API_KEY', 'OPENAI_EXECUTOR_API_KEY'):
        if key := os.environ.get(name):
            text = text.replace(key, '[REDACTED]')
    return text


def save_answer(items):
    ITEMS.write_text(redact(json.dumps(items, indent=2)) + '\n')
    answer = '\n\n'.join(
        part['text'] for item in items
        if item['type'] == 'message' and item.get('phase') == 'final_answer'
        for part in item['content'] if part['type'] == 'output_text').strip()
    executed = any(item['type'] == 'command_execution' and item.get('exit_code') == 0
                   and item.get('status') == 'completed' for item in items)
    if not answer or not executed:
        raise RuntimeError('The turn ended without a final answer or successful code execution. '
                           'Inspect agent-items.json before continuing.')
    ANSWER.write_text(redact(answer) + '\n')
    print('Analysis: COMPLETED\n')
    print(redact(answer))
    print(f'\nSaved {ANSWER.name} and {ITEMS.name}.')


def main():
    application_key = os.environ['OPENAI_API_KEY']
    state = json.loads(STATE.read_text())
    state.setdefault('analysis', {'key': str(uuid.uuid4()), 'prompt': PROMPT})
    save(state)
    session_path = f"/agents/sessions/{state['session_id']}"
    with OpenAI(api_key=application_key, base_url='https://api.openai.com/v1',
                default_headers={'OpenAI-Beta': 'agents=v1'}, timeout=300, max_retries=0) as api:
        turn_id = wait_for_answer(api, session_path, state)
        save_answer(read_items(api, session_path, turn_id))


if __name__ == '__main__':
    try:
        main()
    except FileNotFoundError:
        raise SystemExit('Complete Task 2 first so agent-state.json contains the connected session.')
    except KeyError as error:
        if error.args[0] == 'OPENAI_API_KEY':
            raise SystemExit('Set your OpenAI API key using Task 1.')
        raise
    except APIStatusError as error:
        raise SystemExit(f'OpenAI request failed: HTTP {error.status_code}. '
                         'Check key permissions and session access before retrying.')
    except (APIConnectionError, httpx.TransportError):
        raise SystemExit('Could not reach OpenAI. Check Cloud Shell Public network and rerun this script.')
    except APIError:
        raise SystemExit('OpenAI reported an error. Inspect the session in the OpenAI Agents dashboard before retrying.')
    except (RuntimeError, ValueError) as error:
        raise SystemExit(str(error))

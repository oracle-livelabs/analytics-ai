"""Create a sandbox and read the sample CSV from Object Storage."""
import argparse
import json
import uuid
from pathlib import Path
from urllib.parse import urlparse

import oci
from oci.generative_ai_sandbox import GenerativeAiSandboxClient
from oci.generative_ai_sandbox.models import (
    CreateSandboxDetails, RunSandboxCommandDetails)
from cloud_auth import signer

ROOT = Path(__file__).resolve().parent
CONFIG = ROOT / 'config.json'


def save(config):
    temporary = CONFIG.with_suffix('.tmp')
    temporary.write_text(json.dumps(config, indent=2) + '\n')
    temporary.replace(CONFIG)


def wait_for(client, sandbox_id, state):
    return oci.wait_until(client, client.get_sandbox(sandbox_id),
                          'lifecycle_state', state, max_wait_seconds=180)


def create_sandbox(client, config):
    if not config.get('sandbox_id'):
        config.setdefault('sandbox_create_token', str(uuid.uuid4()))
        save(config)
        sandbox = client.create_sandbox(
            config['project_id'],
            CreateSandboxDetails(
                display_name='workshop-analysis',
                runtime='python-3.11',
                shape='SMALL',
                expiration_duration='PT60M',
            ),
            opc_retry_token=config['sandbox_create_token'],
        ).data
        config['sandbox_id'] = sandbox.id
        save(config)
    wait_for(client, config['sandbox_id'], 'RUNNING')
    print(f"Sandbox: {config['sandbox_id']} (RUNNING)")


def prepare_bucket(config, bucket_name, auth):
    storage = oci.object_storage.ObjectStorageClient({'region': config['region']}, signer=auth)
    config.update(bucket_name=bucket_name, namespace=storage.get_namespace().data,
                  storage_endpoint=oci.regions.endpoint_for('object_storage', region=config['region']))
    save(config)
    print(f"Project: {config['project_name']}")
    print(f"Bucket: {bucket_name}")
    print(f"Object Storage hostname: {urlparse(config['storage_endpoint']).hostname}")


def run_script(client, sandbox_id, script, args=()):
    remote_path = f'/workspace/{script.name}'
    with script.open('rb') as code:
        client.write_sandbox_file(
            sandbox_id, remote_path, code,
        )
    output = client.run_sandbox_command_and_wait(
        sandbox_id,
        RunSandboxCommandDetails(
            command='python',
            args=[remote_path, *args],
            timeout='PT45S',
        ),
        retry_strategy=oci.retry.NoneRetryStrategy(),
    ).data.output
    print(output.stdout or '', end='')
    print(output.stderr or '', end='')
    print(f'Exit code: {output.exit_code}')
    return output


def read_csv(client, config):
    return run_script(client, config['sandbox_id'], ROOT / 'read_csv.py',
                      [config['namespace'], config['bucket_name'], config['region'],
                       config['storage_endpoint']]).exit_code


def arguments():
    parser = argparse.ArgumentParser(description=__doc__)
    actions = parser.add_subparsers(dest='action', required=True)
    actions.add_parser('create').add_argument('bucket_name')
    actions.add_parser('read')
    return parser.parse_args()


def main():
    args = arguments()
    config = json.loads(CONFIG.read_text())
    auth = signer()
    client = GenerativeAiSandboxClient({'region': config['region']}, signer=auth, timeout=(10, 60))
    if args.action == 'read':
        return read_csv(client, config)
    prepare_bucket(config, args.bucket_name, auth)
    create_sandbox(client, config)
    return 0


if __name__ == '__main__':
    try:
        raise SystemExit(main())
    except oci.exceptions.ServiceError as error:
        raise SystemExit(f'OCI request failed: HTTP {error.status} ({error.code}). {error.message}')
    except oci.exceptions.RequestException:
        raise SystemExit('Cloud Shell could not reach OCI. Check Public network and rerun the script.')
    except oci.exceptions.MaximumWaitTimeExceeded:
        raise SystemExit('The sandbox is still changing state. Rerun the script to continue.')

"""Configure the workshop environment and check its project settings."""
import json
import os
import sys
from pathlib import Path

import oci
from cloud_auth import cloud_config, signer

CONFIG_FIELDS = ('region', 'tenancy_id', 'compartment_id', 'compartment_name')
SETUP_ERRORS = (oci.exceptions.ServiceError, oci.exceptions.RequestException, OSError)


def failure_reason(error):
    if isinstance(error, oci.exceptions.ServiceError):
        if error.status == 401:
            recovery = 'Restart Cloud Shell to refresh authentication.'
        elif error.status in (403, 404):
            recovery = 'Check the region, compartment and IAM permissions from Tasks 1 and 2.'
        else:
            recovery = 'Retry; check OCI service status if the error persists.'
        return f'OCI request failed (HTTP {error.status}). {recovery}'
    if isinstance(error, (oci.exceptions.RequestException, TimeoutError)):
        return 'Connection failed. Check Cloud Shell Public network and rerun the setup script.'
    return 'Could not read or save workshop files. Check file permissions and available disk space.'


def report(label, passed, recovery=''):
    print(f'{"✓" if passed else "✗"} {label}')
    if not passed:
        print(f'  {recovery}')
    return passed


def checked(label, operation):
    try:
        result = operation()
    except SETUP_ERRORS as error:
        raise SystemExit(f'✗ {label}: {failure_reason(error)}')
    report(label, True)
    return result


def load_config(optional=False):
    try:
        config = json.loads(Path('config.json').read_text())
    except FileNotFoundError:
        if optional:
            return {}
        raise SystemExit('✗ Saved configuration missing: complete Task 3 first.')
    except ValueError:
        config = None
    if not isinstance(config, dict) or not all(
            isinstance(config.get(key), str) and config[key].strip() for key in CONFIG_FIELDS):
        raise SystemExit('✗ Invalid config.json: rename it to an unused backup name and rerun Task 3.')
    return config


def save_config(config):
    temporary = Path('config.json.tmp')
    temporary.write_text(json.dumps(config, indent=2) + '\n')
    temporary.replace('config.json')


def project_client(config, auth):
    print(f'Region: {config["region"]}')
    print(f'Compartment: {config["compartment_name"]}')
    return oci.generative_ai.GenerativeAiClient({'region': config['region']}, signer=auth)


def check_project(project_name):
    config = load_config()
    projects = project_client(config, signer())
    results = oci.pagination.list_call_get_all_results(
        projects.list_generative_ai_projects, config['compartment_id'],
        display_name=project_name).data
    matches = [p for p in results if p.display_name == project_name
               and p.lifecycle_state not in ('DELETED', 'DELETING')]
    if not matches:
        raise SystemExit('✗ Project found: check the project name, region and compartment, then rerun this step.')
    if len(matches) != 1:
        raise SystemExit('✗ Project found: multiple projects have this name. Give the workshop project a unique name and rerun with that name.')
    # Read the full API response so Sandbox fields are preserved across SDK model versions.
    project = projects.base_client.call_api(
        resource_path='/generativeAiProjects/{projectId}', method='GET',
        path_params={'projectId': matches[0].id},
        header_params={'accept': 'application/json'},
        response_type='dict(str, object)').data
    print(f'✓ Project found: {project_name}')
    sandbox = project.get('sandboxConfig') or {}
    networking = sandbox.get('sandboxOutboundNetworkingConfig') or {}
    policy = networking.get('networkPolicy') or {}
    warm_pool = sandbox.get('warmPoolConfig')
    counts = {'smallCount', 'mediumCount', 'largeCount'}
    no_warm_pool = warm_pool is None or (
        isinstance(warm_pool, dict) and set(warm_pool) <= counts
        and all(value in (None, 0) for value in warm_pool.values()))
    checks = [
        ('Project status: Active', project.get('lifecycleState') == 'ACTIVE',
         'Wait for Active in the Console; if creation failed, inspect the project details.'),
        ('Sandboxes enabled', sandbox.get('isEnabled') is True,
         'Enable Sandboxes in the project settings.'),
        ('Networking mode: Managed', networking.get('networkMode') == 'MANAGED',
         'Set Networking mode to Managed in the project settings.'),
        ('Outbound access: DENY_ALL', policy.get('mode') == 'DENY_ALL',
         'Set the outbound network policy to DENY_ALL in the project settings.'),
        ('Warm pool capacity: 0', no_warm_pool and 'warmPoolConfig' in sandbox,
         'Check the warm pool configuration in the Console and remove any configured pools.')]
    passed = [report(label, passed, recovery) for label, passed, recovery in checks]
    if not all(passed):
        raise SystemExit('Project check incomplete. Resolve the failed checks and rerun this step.')
    config.update(project_id=project['id'], project_name=project_name)
    save_config(config)
    print('✓ Project OCID saved in config.json')
    print('Setup complete. Continue to Lab 2.')



def configure(compartment_name):
    previous = load_config(optional=True)
    report('Cloud Shell session', True)
    source = cloud_config()
    region = os.environ.get('OCI_CLI_REGION') or source['region']
    auth = signer()
    identity = oci.identity.IdentityClient({'region': region}, signer=auth)
    response = checked('OCI authentication and compartment discovery', lambda:
        oci.pagination.list_call_get_all_results(
            identity.list_compartments, source['tenancy'],
            compartment_id_in_subtree=True, access_level='ACCESSIBLE'))
    choices = sorted((c for c in response.data if c.lifecycle_state == 'ACTIVE'),
                     key=lambda c: (c.name, c.id))
    if not choices:
        raise SystemExit('✗ No accessible compartments. Check Tasks 1 and 2.')
    matches = [c for c in choices if c.name == compartment_name]
    if len(matches) == 1:
        compartment = matches[0]
    else:
        print(f'Could not uniquely select {compartment_name}. Choose the compartment from Task 1:')
        for number, compartment in enumerate(choices, 1):
            print(f'{number}. {compartment.name}  ({compartment.id})')
        while True:
            selection = input('Workshop compartment number: ').strip()
            if selection.isdigit() and 1 <= int(selection) <= len(choices):
                break
            print('Enter a number from the list.')
        compartment = choices[int(selection) - 1]
    config = {'region': region, 'tenancy_id': source['tenancy'],
              'compartment_id': compartment.id, 'compartment_name': compartment.name}
    projects = project_client(config, auth)
    checked('Project list permission in the workshop compartment',
            lambda: projects.list_generative_ai_projects(compartment.id, limit=1))
    # Preserve saved exercise resources only when the target is unchanged.
    if all(previous.get(key) == config[key] for key in ('region', 'tenancy_id', 'compartment_id')):
        config = previous | config
    save_config(config)
    print('Saved config.json. Initial access checks passed. Ready for project creation.')


if __name__ == '__main__':
    try:
        # setup.sh validates arguments and the Cloud Shell environment.
        if sys.argv[1] == '--check-project':
            check_project(sys.argv[2])
        else:
            configure(sys.argv[1])
    except SETUP_ERRORS as error:
        raise SystemExit(f'✗ {failure_reason(error)}')
    except (KeyboardInterrupt, EOFError):
        raise SystemExit('\nSetup cancelled. Rerun the setup script when ready.')
    except (oci.exceptions.ConfigFileNotFound, oci.exceptions.ProfileNotFound, KeyError):
        raise SystemExit('✗ Required configuration is unavailable. Restart Cloud Shell and rerun the setup script.')

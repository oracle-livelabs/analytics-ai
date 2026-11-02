"""Print the IAM policy for reading the workshop bucket from a sandbox."""
import argparse
import json
from pathlib import Path

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('bucket_name', help='Name of the bucket created in Lab 2.')
args = parser.parse_args()

try:
    config = json.loads(Path(__file__).with_name('config.json').read_text())
except (OSError, ValueError):
    raise SystemExit('Cannot read config.json. Complete the setup script steps in Lab 1.')

if not isinstance(config, dict) or not all(
        isinstance(config.get(key), str) and config[key].strip()
        for key in ('compartment_id', 'project_id')):
    raise SystemExit('Compartment or project OCID missing. Complete the setup script steps in Lab 1.')

print(
    f"Allow any-user to read objects in compartment id {config['compartment_id']} "
    "where all {request.principal.type = 'generativeaisandbox', "
    f"request.principal.project_id = '{config['project_id']}', "
    f"target.bucket.name = '{args.bucket_name}'}}"
)

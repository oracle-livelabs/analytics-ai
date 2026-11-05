"""Download the sample CSV inside a sandbox using its resource principal."""
import sys
from pathlib import Path

import oci

namespace, bucket, region, endpoint = sys.argv[1:]
client = oci.object_storage.ObjectStorageClient(
    {'region': region},
    signer=(
        oci.auth.signers.get_resource_principals_signer()
    ),
    service_endpoint=endpoint,
    timeout=(5, 15),
    retry_strategy=oci.retry.NoneRetryStrategy(),
)

try:
    response = client.get_object(
        namespace, bucket, 'monthly-financials.csv',
    )
except oci.exceptions.RequestException:
    raise SystemExit('Object Storage connection failed. Check the project outbound network policy.')
except oci.exceptions.ServiceError as error:
    raise SystemExit(
        f'Object Storage returned HTTP {error.status} ({error.code}). '
        'Check the bucket name, uploaded object and policy from Task 2. '
        'If the policy was just created, wait a minute and retry.')

destination = Path('/workspace/monthly-financials.csv')
destination.write_bytes(response.data.content)
print(f'Downloaded {destination.name} from bucket {bucket}.')
print(f'Saved to {destination}.')
print(destination.read_text())

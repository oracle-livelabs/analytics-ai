"""Authenticate OCI SDK requests as the signed-in Cloud Shell user."""
import os
from pathlib import Path

import oci
from oci_genai_auth.auth import HttpxOciAuth


def cloud_config():
    return oci.config.from_file(
        os.environ['OCI_CLI_CONFIG_FILE'], os.environ['OCI_CLI_PROFILE'])


def signer():
    config = cloud_config()
    token_file = os.environ.get('OCI_CLI_DELEGATION_TOKEN_FILE') or config['delegation_token_file']
    return oci.auth.signers.InstancePrincipalsDelegationTokenSigner(
        delegation_token=Path(token_file).expanduser().read_text().strip())


class CloudShellAuth(HttpxOciAuth):
    """Sign OpenAI SDK requests with the Cloud Shell user's OCI identity."""

    def __init__(self):
        super().__init__(signer=signer())

    def _refresh_signer(self):
        self.signer = signer()

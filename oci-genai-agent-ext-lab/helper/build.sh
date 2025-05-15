SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR/..

. $SCRIPT_DIR/env.sh
action/sshkey_generate.sh
# . action/idcs_confidential_app.sh
. action/env_pre_terraform.sh
action/terraform.sh
. action/env_post_terraform.sh
echo "--- DONE ---"


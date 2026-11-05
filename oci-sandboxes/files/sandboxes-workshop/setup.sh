#!/bin/bash
set -Eeuo pipefail
stage='opening the workshop folder'
trap 'printf "\nSetup stopped while %s. Fix the error above, then rerun the setup script.\n" "$stage" >&2' ERR
cd "$(dirname "$0")"

fail() {
    printf '✗ %s\n' "$1" >&2
    exit 1
}

python_supported() {
    "$1" -c 'import sys; sys.exit(sys.version_info < (3, 11))' >/dev/null 2>&1
}

[[ $# -gt 0 ]] || set -- "sandboxes-workshop"
case $1 in
    --check-project)
        [[ $# -eq 2 && -n ${2//[[:space:]]/} ]] || fail 'Usage: bash setup.sh --check-project "sandboxes-analysis"'
        ;;
    -*) fail 'Use bash setup.sh "sandboxes-workshop" or bash setup.sh --check-project "sandboxes-analysis"' ;;
    *)
        [[ $# -eq 1 && -n ${1//[[:space:]]/} ]] || fail 'Supply one compartment name in quotes.'
        ;;
esac

[[ ${OCI_CLI_AUTH:-} == instance_obo_user ]] || fail 'Run the setup script in OCI Cloud Shell using its default authentication.'

if [[ $1 == --check-project ]]; then
    python_supported .venv/bin/python || fail 'Complete Task 3 before checking the project.'
    .venv/bin/python -c 'import oci' 2>/dev/null || fail 'The OCI SDK is unavailable. Rerun the setup script from Task 3.'
else
    stage='preparing Python'
    if [[ ! -e .venv ]]; then
        workshop_python=''
        for candidate in python3 python3.12 python3.11 python3.13 python3.14; do
            if python_supported "$candidate"; then
                workshop_python=$candidate
                break
            fi
        done
        [[ -n $workshop_python ]] || fail 'Run csruntimectl python list, then csruntimectl python set <alias> with a listed Python 3.11-or-newer alias. Rerun the setup script afterward.'
        "$workshop_python" -m venv .venv
    fi
    python_supported .venv/bin/python || fail 'The existing .venv is incomplete or uses older Python. Rename it to an unused backup name, then rerun the setup script.'
    .venv/bin/python --version

    stage='installing the OCI SDK (check Public network and available disk space if installation fails)'
    .venv/bin/python -m pip install --disable-pip-version-check --retries 2 --timeout 30 -r requirements.txt
fi

exec .venv/bin/python configure.py "$@"

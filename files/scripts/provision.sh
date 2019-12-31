#!/bin/bash
set -eo pipefail

NAMESPACE=$1
if [ "${NAMESPACE}" == "" ]; then
    echo "Usage: ${0} <namespace>"
    exit 1
fi

/opt/muna/scripts/setup_ssenv "${NAMESPACE}"
/opt/muna/scripts/setup_secrets "${NAMESPACE}"
/opt/muna/scripts/setup_ssl "${NAMESPACE}"

systemctl reload apache2

if [ "$(systemctl is-active nginx)" != "unknown" ]; then
    systemctl reload nginx
fi
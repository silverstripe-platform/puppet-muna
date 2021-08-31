#!/bin/bash
set -eo pipefail

NAMESPACE=$1
if [ "${NAMESPACE}" == "" ]; then
    echo "Usage: ${0} <namespace>"
    exit 1
fi

if [ ! -f "/opt/muna/.enabled" ]; then
    echo "Muna not enabled, exiting"
    exit 1
fi

/opt/muna/scripts/setup_ssenv "${NAMESPACE}"
/opt/muna/scripts/setup_secrets "${NAMESPACE}"
systemctl reload apache2

# Only try to setup SSL and reload nginx if it is installed and running
if [ systemctl is-active --quiet nginx ]; then
    # Install SSL Certificates and reload Nginx
    /opt/muna/scripts/setup_ssl "${NAMESPACE}"
    systemctl reload nginx
fi
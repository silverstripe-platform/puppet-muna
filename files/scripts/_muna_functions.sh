#!/bin/bash
# /opt/muna/scripts/_muna_functions.sh
# Shared bash helpers for muna scripts. Source this file, do not execute directly.

MUNA_BIN="/opt/muna/bin/muna"
NAMESPACE_CONFIG="/opt/muna/conf/namespaces.ini"

# Output a message to stdout
output() {
    echo "$1"
}

# Output a message and exit with code (default 0)
quit() {
    output "$1"
    exit "${2:-0}"
}

# Parse a value from the muna INI file by section and key
# Usage: ini_get <section> <key>
ini_get() {
    php -r "echo (parse_ini_file('$NAMESPACE_CONFIG', true)['$1']['$2'] ?? '');"
}

# Detect AWS region from instance metadata (IMDSv2)
get_region() {
    local token
    token=$(curl -s --connect-timeout 2 -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600" 2>/dev/null || echo "")
    if [ -n "$token" ]; then
        curl -s --connect-timeout 2 -H "X-aws-ec2-metadata-token: $token" http://169.254.169.254/latest/meta-data/placement/region 2>/dev/null || echo ""
    else
        echo ""
    fi
}

# Validate an AWS region string
is_region() {
    local region="$1"
    case "$region" in
        ap-southeast-2|ap-southeast-6|eu-west-1|us-west-2) return 0 ;;
        *) return 1 ;;
    esac
}

# Check muna is available. Returns 1 if not.
require_muna() {
    if [ ! -x "$MUNA_BIN" ]; then
        return 1
    fi
    if [ ! -f "$NAMESPACE_CONFIG" ]; then
        return 1
    fi
    return 0
}

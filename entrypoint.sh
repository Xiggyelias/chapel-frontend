#!/bin/sh
set -e

echo "=== Kwang-Lim Chapel Frontend Gateway Bootstrapping ==="

# 1. Determine upstream backend
if [ -z "$BACKEND_URL" ]; then
    # Default to internal Dokploy container name for private, zero-Cloudflare networking
    if ping -c 1 -W 1 chap-chapelbackend-4a2fk2 >/dev/null 2>&1; then
        export BACKEND_URL="http://chap-chapelbackend-4a2fk2:80"
    elif ping -c 1 -W 1 backend >/dev/null 2>&1; then
        export BACKEND_URL="http://backend:80"
    elif ping -c 1 -W 1 chapel-backend >/dev/null 2>&1; then
        export BACKEND_URL="http://chapel-backend:80"
    else
        export BACKEND_URL="http://chap-chapelbackend-4a2fk2:80"
    fi
fi

# 2. Extract host domain from BACKEND_URL (strip protocol and port)
BACKEND_HOST=$(echo "$BACKEND_URL" | sed -e 's|^[^/]*//||' -e 's|/.*$||' -e 's|:.*$||')
export BACKEND_HOST=${BACKEND_HOST:-chap-chapelbackend-4a2fk2}

echo "Upstream Backend Configuration:"
echo " - Upstream URL:  ${BACKEND_URL}"
echo " - Upstream Host: ${BACKEND_HOST}"

# 3. Substitute values into Nginx configuration
sed -i "s|\${BACKEND_URL}|${BACKEND_URL}|g" /etc/nginx/conf.d/default.conf
sed -i "s|\${BACKEND_HOST}|${BACKEND_HOST}|g" /etc/nginx/conf.d/default.conf

exec "$@"

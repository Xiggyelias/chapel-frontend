#!/bin/sh
set -e

# Default BACKEND_URL if not provided in environment
export BACKEND_URL=${BACKEND_URL:-https://ChapelCMapi.africau.co.zw}

# Extract host domain from BACKEND_URL (strip protocol and paths)
BACKEND_HOST=$(echo "$BACKEND_URL" | sed -e 's|^[^/]*//||' -e 's|/.*$||' -e 's|:.*$||')
export BACKEND_HOST=${BACKEND_HOST:-ChapelCMapi.africau.co.zw}

echo "Configuring Nginx Reverse Proxy:"
echo " - Upstream URL:  ${BACKEND_URL}"
echo " - Upstream Host: ${BACKEND_HOST}"

# Substitute in nginx configuration
sed -i "s|\${BACKEND_URL}|${BACKEND_URL}|g" /etc/nginx/conf.d/default.conf
sed -i "s|\${BACKEND_HOST}|${BACKEND_HOST}|g" /etc/nginx/conf.d/default.conf

exec "$@"

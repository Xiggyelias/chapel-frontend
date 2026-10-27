#!/bin/sh
set -e

# Default BACKEND_URL if not provided in environment
export BACKEND_URL=${BACKEND_URL:-https://ChapelCMapi.africau.co.zw}

# Substitute BACKEND_URL in nginx configuration
sed -i "s|\${BACKEND_URL}|${BACKEND_URL}|g" /etc/nginx/conf.d/default.conf

exec "$@"

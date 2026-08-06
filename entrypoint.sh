#!/bin/sh

. /lib.subr

set -e

create_user

APPDIR="/usr/local/www/homepage"

export HOMEPAGE_BUILDTIME=$(date +%s)

# Try IPv6 first (dual stack when available), but fall back to IPv4 if the bind fails
export HOSTNAME=${HOSTNAME:-::}
if [ "$HOSTNAME" = "::" ]; then
  if ! node -e "const server = require('http').createServer(() => {}); const host = '::'; const port = process.env.PORT || 3000; server.once('error', (err) => { console.error('IPv6 bind failed:', err.message); process.exit(1); }); server.listen(port, host, () => server.close(() => process.exit(0)));"; then
    echo "Falling back to IPv4 bind at 0.0.0.0"
    export HOSTNAME=0.0.0.0
  fi
fi

change_owner "${APPDIR}/config"

if [ -d "${APPDIR}/.next" ]; then
    change_owner "${APPDIR}/.next"
fi

if [ "$(id -u)" = 0 ]; then
    set -- su-exec noroot "$@"
fi

exec "$@"

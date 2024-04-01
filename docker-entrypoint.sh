#!/usr/bin/env bash

set -o errexit

# Default to root user
export PGID=${PGID:-0}
export PUID=${PUID:-0}

# Set privileges for /var/cache/buildkit/pip but only if pid 1 user is root and we are dropping privileges.
# If container is run as an unprivileged user, it means owner already handled ownership setup on their own.
# Running chown in that case (as non-root) will cause error
[ "$(id -u)" == "0" ] && [ "${PUID}" != "0" ] && chown --recursive "${PUID}:${PGID}" "${PIP_CACHE_DIR}"

# Drop privileges (when asked to) if root, otherwise run as current user
if [ "$(id -u)" == "0" ] && [ "${PUID}" != "0" ]; then
	su -c "$0" "${PUID}" "$@"
else
	exec "$@"
fi

set +o errexit

#!/bin/bash
# entrypoint.sh
set -e

# Remove a potentially pre-existing server.pid
rm -f /myapp/tmp/pids/server.pid

exec "$@"
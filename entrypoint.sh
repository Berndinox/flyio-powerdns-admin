#!/bin/sh
set -euo pipefail
cd /app

GUNICORN_TIMEOUT="${GUNICORN_TIMEOUT:-60}"
GUNICORN_WORKERS="${GUNICORN_WORKERS:-4}"
GUNICORN_LOGLEVEL="${GUNICORN_LOGLEVEL:-info}"
GUNICORN_CACHEFOLDER="/dev/shm"
BIND_ADDRESS="${BIND_ADDRESS:-0.0.0.0:80}"

GUNICORN_ARGS="-t ${GUNICORN_TIMEOUT} --workers ${GUNICORN_WORKERS} --bind ${BIND_ADDRESS} --log-level ${GUNICORN_LOGLEVEL} --worker-tmp-dir ${GUNICORN_CACHEFOLDER}"

cat /app/powerdnsadmin/engine_config.py >> /app/powerdnsadmin/docker_config.py


if [ "$1" == gunicorn ]; then
    /bin/sh -c "flask db upgrade"
    supercronic -quiet /app/crontab &
    exec "$@" $GUNICORN_ARGS
else
    supercronic -quiet /app/crontab &
    exec "$@"
fi
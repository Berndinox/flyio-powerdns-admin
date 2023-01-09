FROM powerdnsadmin/pda-legacy:latest
# Source: https://github.com/PowerDNS-Admin/
USER root

COPY --chown=${USER}:${USER} entrypoint.sh /usr/bin/
COPY --chown=${USER}:${USER} engine_config.py /app/powerdnsadmin/

USER ${USER}
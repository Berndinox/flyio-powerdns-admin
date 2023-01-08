FROM powerdnsadmin/pda-legacy:latest
# Source: https://github.com/PowerDNS-Admin/
USER root

COPY entrypoint.sh /usr/bin/
COPY engine_config.py /app/powerdnsadmin/

RUN chown ${USER}:${USER} /app/powerdnsadmin/engine_config.py /app/powerdnsadmin/docker_config.py

USER ${USER}
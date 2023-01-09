FROM powerdnsadmin/pda-legacy:latest
# Source: https://github.com/PowerDNS-Admin/
USER root

RUN apk --update --no-cache add \
        curl \
        jq \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/* \
    && rm -rf /var/log/* \
    && echo "*/5 * * * * * * cron.sh" > /app/crontab

COPY --chown=${USER}:${USER} entrypoint.sh /usr/bin/
COPY --chown=${USER}:${USER} cron.sh /usr/bin/
COPY --chown=${USER}:${USER} engine_config.py /app/powerdnsadmin/

RUN chown ${USER}:${USER} /app/powerdnsadmin/engine_config.py /app/powerdnsadmin/docker_config.py /app/crontab \
    && chown -R ${USER}:${USER} /app/powerdnsadmin/static \
    && chmod +x /usr/bin/cron.sh

ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.2.1/supercronic-linux-amd64 \
    SUPERCRONIC=supercronic-linux-amd64 \
    SUPERCRONIC_SHA1SUM=d7f4c0886eb85249ad05ed592902fa6865bb9d70

RUN curl -fsSLO "$SUPERCRONIC_URL" \
    && echo "${SUPERCRONIC_SHA1SUM}  ${SUPERCRONIC}" | sha1sum -c - \
    && chmod +x "$SUPERCRONIC" \
    && mv "$SUPERCRONIC" "/usr/local/bin/${SUPERCRONIC}" \
    && ln -s "/usr/local/bin/${SUPERCRONIC}" /usr/local/bin/supercronic

USER ${USER}
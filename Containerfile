ARG FREEBSD_RELEASE

FROM ghcr.io/appjail-makejails/core:${FREEBSD_RELEASE}

ARG NO_PKGCLEAN

LABEL org.opencontainers.image.title="Homepage" \
    org.opencontainers.image.description="Highly customizable homepage (or startpage / application dashboard) with Docker and service API integrations" \
    org.opencontainers.image.source="https://github.com/AppJail-makejails/homepage" \
    org.opencontainers.image.url="https://github.com/AppJail-makejails/homepage" \
    org.opencontainers.image.vendor="DtxdF" \
    org.opencontainers.image.authors="Jesús Daniel Colmenares Oviedo <dtxdf@disroot.org>"

RUN set -xe; \
    \
    pkg update; \
    pkg install homepage; \
    \
    if [ -z "${NO_PKGCLEAN}" ]; then \
        pkg clean -a; \
        rm -rf /var/cache/pkg/*; \
    fi; \
    rm -rf /var/db/pkg/repos/*

COPY entrypoint.sh /

RUN mv /usr/local/www/homepage/config /config && \
    ln -s /config /usr/local/www/homepage/config && \
    chmod 755 /usr/local/www/homepage/config

RUN chmod +x /entrypoint.sh

WORKDIR /usr/local/www/homepage

ENV NODE_ENV=production
ENV HOSTNAME=::
ENV PORT=3000
EXPOSE $PORT

VOLUME /config

USER root

ENTRYPOINT ["/entrypoint.sh"]
CMD ["node", "server.js"]

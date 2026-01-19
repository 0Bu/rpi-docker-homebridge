FROM ubuntu:24.04@sha256:cd1dba651b3080c3686ecf4e3c4220f026b521fb76978881737d24f200828b2b

LABEL org.opencontainers.image.source="https://github.com/0Bu/rpi-docker-homebridge"
LABEL org.opencontainers.image.description="homebridge.io docker image for raspberry pi"
LABEL org.opencontainers.image.licenses="MIT"

# renovate: datasource=github-releases depName=homebridge/homebridge-apt-pkg
ARG HOMEBRIDGE_APT_PKG_VERSION="v1.8.9"
ENV UIX_CAN_SHUTDOWN_RESTART_HOST=1

RUN apt-get update && apt-get install -y curl gpg \
    && curl -sSfL https://repo.homebridge.io/KEY.gpg | gpg --dearmor > /usr/share/keyrings/homebridge.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/homebridge.gpg] https://repo.homebridge.io stable main" > /etc/apt/sources.list.d/homebridge.list \
    && apt-get update && apt-get install -y homebridge=$(echo "${HOMEBRIDGE_APT_PKG_VERSION}" | grep -Po '\d.+' ) \
    && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* 

EXPOSE 8581/tcp
VOLUME /var/lib/homebridge
WORKDIR /var/lib/homebridge
ENTRYPOINT ["/opt/homebridge/start.sh"]
CMD ["--allow-root"]


FROM ubuntu:26.04@sha256:f3d28607ddd78734bb7f71f117f3c6706c666b8b76cbff7c9ff6e5718d46ff64

LABEL org.opencontainers.image.source="https://github.com/0Bu/rpi-docker-homebridge"
LABEL org.opencontainers.image.description="homebridge.io docker image for raspberry pi"
LABEL org.opencontainers.image.licenses="MIT"

# renovate: datasource=github-releases depName=homebridge/homebridge-apt-pkg
ARG HOMEBRIDGE_APT_PKG_VERSION="v2.0.2"
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


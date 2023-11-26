FROM ubuntu:22.04

LABEL org.opencontainers.image.source=https://github.com/0Bu/rpi-docker-homebridge

# renovate: datasource=github-releases depName=homebridge/homebridge-apt-pkg
ENV HOMEBRIDGE_PKG_VERSION="1.1.3"
ENV UIX_CAN_SHUTDOWN_RESTART_HOST=1

RUN apt-get update && apt-get install -y curl gpg \
    && curl -sSfL https://repo.homebridge.io/KEY.gpg | gpg --dearmor > /usr/share/keyrings/homebridge.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/homebridge.gpg] https://repo.homebridge.io stable main" > /etc/apt/sources.list.d/homebridge.list \
    && apt-get update && apt-get install -y homebridge=${HOMEBRIDGE_PKG_VERSION} \
    && apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* 

EXPOSE 8581/tcp
VOLUME /var/lib/homebridge
WORKDIR /var/lib/homebridge
CMD /opt/homebridge/start.sh --allow-root


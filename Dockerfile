FROM ubuntu:22.04

ENV HOMEBRIDGE_PKG_VERSION=1.1.3 \
    UIX_CAN_SHUTDOWN_RESTART_HOST=1

RUN apt-get update && apt-get install -y curl gpg \
    && curl -sSfL https://repo.homebridge.io/KEY.gpg | gpg --dearmor | tee /usr/share/keyrings/homebridge.gpg  > /dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/homebridge.gpg] https://repo.homebridge.io stable main" | tee /etc/apt/sources.list.d/homebridge.list > /dev/null \
    && apt-get update \
#    && apt-get install -y homebridge=${HOMEBRIDGE_PKG_VERSION} \
    && apt-get install -y homebridge=1.1.2 \
    && apt-get clean \
    && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* 

EXPOSE 8581/tcp
VOLUME /var/lib/homebridge
WORKDIR /var/lib/homebridge
CMD /opt/homebridge/start.sh --allow-root


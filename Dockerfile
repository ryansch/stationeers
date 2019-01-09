FROM ryansch/steamcmd:latest
LABEL maintainer="Ryan Schlesinger <ryan@ryanschlesinger.com>"

WORKDIR /

RUN apt-get update && apt-get install -y --no-install-recommends \
    pwgen \
    unzip \
  && rm -rf /var/lib/apt/lists/* && \
  /steamcmd/steamcmd.sh +login anonymous +force_install_dir /opt/stationeers +app_update 600760 +quit && \
  mkdir -p /var/opt/stationeers && \
  mkdir -p /root/.config/unity3d/Rocketwerkz/rocketstation && \
  ln -s /var/opt/stationeers/log/Player.log /root/.config/unity3d/Rocketwerkz/rocketstation/Player.log

ENV SRCON_VERSION 1.2.0

RUN wget https://github.com/matjam/stationeersrcon/releases/download/v$SRCON_VERSION/srcon-$SRCON_VERSION-linux.zip \
  && unzip srcon-$SRCON_VERSION-linux.zip \
  && mv srcon /usr/local/bin/

COPY docker-entrypoint.sh /

VOLUME /var/opt/stationeers

EXPOSE 27500/udp 27015/udp

ENTRYPOINT ["/docker-entrypoint.sh"]

COPY healthcheck.sh /
HEALTHCHECK --interval=30s --timeout=30s --start-period=2m --retries=3 CMD /healthcheck.sh

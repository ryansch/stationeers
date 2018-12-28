FROM ryansch/steamcmd:latest
LABEL maintainer="Ryan Schlesinger <ryan@ryanschlesinger.com>"

ARG MANIFEST=3137232442036833632

WORKDIR /

RUN apt-get update && apt-get install -y --no-install-recommends \
    pwgen \
  && rm -rf /var/lib/apt/lists/* && \
  /steamcmd/steamcmd.sh +login anonymous +download_depot 600760 600762 $MANIFEST +quit && \
  mv /steamcmd/linux32/steamapps/content/app_600760/depot_600762 /opt/stationeers && \
  rm -rf /steamcmd/linux32/steamapps/content/app_600760 && \
  find /opt/stationeers -name ".svn" -type d -depth -exec rm -r "{}" \; && \
  mkdir -p /var/opt/stationeers && \
  mkdir -p /root/.config/unity3d/Rocketwerkz/rocketstation && \
  ln -s /var/opt/stationeers/log/Player.log /root/.config/unity3d/Rocketwerkz/rocketstation/Player.log

COPY docker-entrypoint.sh /

VOLUME /var/opt/stationeers

EXPOSE 27500/udp 27015/udp

ENTRYPOINT ["/docker-entrypoint.sh"]

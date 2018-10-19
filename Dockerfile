FROM biseque/steamcmd
MAINTAINER https://github.com/dtandersen/stationeers

ARG MANIFEST=6876049737833862248

WORKDIR /

RUN apt-get update && \
  apt-get pwgen -y \
  /steamcmd/steamcmd.sh +login anonymous +download_depot 600760 600762 $MANIFEST +quit && \
  mv /steamcmd/linux32/steamapps/content/app_600760/depot_600762 /opt/stationeers && \
  rm -rf /steamcmd/linux32/steamapps/content/app_600760

RUN find /opt/stationeers -name ".svn" -type d -depth -exec rm -r "{}" \;
RUN mkdir -p /var/opt/stationeers/saves
RUN mkdir -p /var/opt/stationeers/logs
RUN mkdir -p /root/.config/unity3d/Rocketwerkz/rocketstation
RUN ln -s /var/opt/stationeers/logs/Player.log /root/.config/unity3d/Rocketwerkz/rocketstation/Player.log

COPY docker-entrypoint.sh /

VOLUME /var/opt/stationeers

EXPOSE 27500/udp 27015/udp

ENTRYPOINT ["/docker-entrypoint.sh"]

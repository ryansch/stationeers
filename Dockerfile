FROM biseque/steamcmd
MAINTAINER biseque <info@biseque.com>

ARG MANIFEST=6876049737833862248
RUN /steamcmd/steamcmd.sh +login anonymous +download_depot 600760 600762 $MANIFEST +quit && \
  mv /steamcmd/linux32/steamapps/content/app_600760/depot_600762 /opt/stationeers && \
  rm -rf /steamcmd/linux32/steamapps/content/app_600760

RUN mkdir -p /var/opt/stationeers/saves
RUN mkdir -p /var/opt/stationeers/logs
RUN mkdir -p /root/.config/unity3d/Rocketwerkz/rocketstation
RUN touch /var/opt/stationeers/default.ini
RUN ln -s /var/opt/stationeers/saves /opt/stationeers/saves
RUN ln -s /var/opt/stationeers/default.ini /opt/stationeers/default.ini
RUN ln -s /var/opt/stationeers/logs/Player.log /root/.config/unity3d/Rocketwerkz/rocketstation/Player.log
#RUN ln -s /opt/stationeers/default.ini /var/opt/default.ini
COPY default.ini /var/opt/stationeers
VOLUME /var/opt/stationeers
WORKDIR /opt/stationeers

EXPOSE 27500/udp 27015/udp

ENTRYPOINT ["./rocketstation_DedicatedServer.x86_64"]

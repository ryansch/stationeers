FROM biseque/steamcmd
MAINTAINER biseque <info@biseque.com>

ARG MANIFEST=6864339739734056751
RUN /steamcmd/steamcmd.sh +login anonymous +download_depot 600760 600762 $MANIFEST +quit && \
  mv /steamcmd/linux32/steamapps/content/app_600760/depot_600762 /data && \
  rm -rf /steamcmd/linux32/steamapps/content/app_600760

WORKDIR /data
VOLUME ["/data/saves"]

EXPOSE 27500/udp 27015/udp

ENTRYPOINT ["./rocketstation_DedicatedServer.x86_64"]

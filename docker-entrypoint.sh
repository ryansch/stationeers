#!/bin/bash -x
set -e

BASE=/var/opt/stationeers
mkdir -p $BASE/log

if [ ! -f $BASE/default.ini ]; then
  cp /opt/stationeers/rocketstation_DedicatedServer_Data/StreamingAssets/default.ini $BASE
  # change default password
  sed -i s/RCONPASSWORD=stationeers/RCONPASSWORD=$(pwgen 15 1)/g $BASE/default.ini
fi

exec /opt/stationeers/rocketstation_DedicatedServer.x86_64 \
  -batchmode -nographics -autostart \
  -basedirectory=$BASE \
  "$@"

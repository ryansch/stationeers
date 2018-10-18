#!/bin/bash -x
set -e

BASE=/var/opt/stationeers

if [ ! -f $BASE/default.ini ]; then
  cp /opt/stationeers/rocketstation_DedicatedServer_Data/StreamingAssets/default.ini $BASE
fi

exec /opt/stationeers/rocketstation_DedicatedServer.x86_64 \
  -batchmode -nographics -autostart \
  -basedirectory=$BASE \
  "$@"

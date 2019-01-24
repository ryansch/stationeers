#!/bin/bash
set -e

BASE=/var/opt/stationeers
mkdir -p $BASE/log

if [ ! -f $BASE/default.ini ]; then
  cp /opt/stationeers/rocketstation_DedicatedServer_Data/StreamingAssets/default.ini $BASE
  # change default password
  sed -i s/RCONPASSWORD=stationeers/RCONPASSWORD=$(pwgen 15 1)/g $BASE/default.ini
fi

RCONPASSWORD=$(egrep 'RCONPASSWORD=.+$' $BASE/default.ini | cut -d '=' -f2 | tr -d '\n\r')

cat << EOF > /root/.srcon
{
  "password": "$RCONPASSWORD",
  "hostname": "127.0.0.1",
  "port": "27500"
}
EOF

tail --pid $$ -F /root/.config/unity3d/Rocketwerkz/rocketstation/Player.log &

exec /opt/stationeers/rocketstation_DedicatedServer.x86_64 \
  -batchmode -nographics -autostart \
  -basedirectory=$BASE \
  "$@"

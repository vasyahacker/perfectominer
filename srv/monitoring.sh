#!/bin/bash
todir="/tmp/localstate"
mkdir -p $todir
while true
do
  df -h > $todir/df
  top -bn3 | awk '/^top -/ { p=!p } { if (!p) print }' > $todir/top
  lan="`/srv/work/traffic.sh eth0`"
  wlan="`/srv/work/traffic.sh wlan0`"
  echo -e "Lan:\n$lan\nWlan:\n$wlan" > $todir/traffic
done

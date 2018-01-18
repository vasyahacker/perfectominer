#!/bin/bash
[ ! -d /srv/stats/$1/quests ] && echo "offline" && exit 0
[ -f /srv/stats/$1/offline ] && echo "offline" && exit 0
MAC=$1
IP=`cat /srv/stats/$1/ip`
ping -c1 $IP >/dev/null && echo "good" || echo "noping"

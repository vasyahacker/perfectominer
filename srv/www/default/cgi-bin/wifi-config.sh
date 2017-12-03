#!/bin/bash
#[ ! -d /srv/stats/$1/quests ] && echo "error" && exit 0
saveIFS=$IFS
IFS='=&'
parm=($@)
IFS=$saveIFS
SSID="${parm[1]}"

wpa_cli reconfigure

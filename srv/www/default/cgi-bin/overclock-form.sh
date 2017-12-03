#!/bin/bash
#[ ! -d /srv/stats/$1/quests ] && echo "offline" && exit 0
. tpl/build.sh
ID=$1
mac=$1
HTML="`cat tpl/overclock-form.tpl`"
[ ! -e /srv/stats/$ID/num-cuda-devices ] && echo "Sorry, this function only for cuda devices.." && exit 0
wdir="/srv/work/ers/$ID"
cardlist="`tpl/card-list.sh $ID`"

html_build "$HTML"

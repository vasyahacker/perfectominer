#!/bin/bash
#[ ! -d /srv/stats/$1/quests ] && echo "offline" && exit 0
. tpl/build.sh
ID=$1
HTML="`cat tpl/farm-control.tpl`"
#HTML="${HTML//\{/\$}"
#HTML="${HTML//\}/}"
wdir="/srv/work/ers/$ID"
sdir="/srv/stats/$ID"
name=`cat $wdir/name`
[ -e $wdir/descr ] && descr=`cat $wdir/descr` || descr="no rig description"
IP="`cat $sdir/ip`"
state=`cgi-bin/farm-state.sh $ID`
gpio=`cat $wdir/gpio || echo "none"`
overclockform="`cgi-bin/overclock-form.sh $ID`"
minerlog="`cgi-bin/farm-log.sh $ID`"
questlog="`cgi-bin/quest-log.sh $ID`"
toplog="`cgi-bin/farm-top.sh $ID`"
farmstats="`cgi-bin/farm-stats.sh $ID`"
html_build "$HTML"

#echo "$HTML"

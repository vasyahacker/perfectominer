#!/bin/bash
wdir="/srv/work/ers/$1"
sdir="/srv/stats/$1/quests"

[ ! -d $wdir ] && echo "error" && exit 0
[ ! -f $wdir/gpio ] && echo "no gpio" && exit 0
gpio=`cat $wdir/gpio`
echo "$gpio" > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio$gpio/direction
echo "0" > /sys/class/gpio/gpio$gpio/value
sleep 1
echo "1" > /sys/class/gpio/gpio$gpio/value
[ -d $sdir ] && echo "`date`: Hard button pressed" >> $sdir/log

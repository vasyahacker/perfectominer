#!/bin/bash

HTML="`cat tpl/farm-item.tpl`"
HTML="${HTML//\{/\$\{}"
#HTML="${HTML//\}/}"
workers=/srv/work/ers
farms="`(cd $workers && ls -d */ | cut -f1 -d'/')`"
num=1
for farm in $farms; do
	wdir=$workers/$farm
	sdir=/srv/stats/$farm
	MAC="$farm"
	Name="`cat $wdir/name`"
	Currency="`cat $wdir/coins`"
	GPUs="hz"
	Hashrate="hz"
  Temp="`cat $sdir/gpustemp`"
	IP="hz"
	if [ -d $sdir ];then
		IP="`cat $sdir/ip`"
		State="`cgi-bin/farm-state.sh $MAC`"
	else
		State="offline"
	fi
	title="mac: $MAC, ip: $IP, state: $State"
  eval "echo \"$HTML\""
	((num++)) 
done

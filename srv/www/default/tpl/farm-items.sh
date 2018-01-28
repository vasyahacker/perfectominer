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
	[ -e $wdir/descr ] && descr="`cat $wdir/descr`" || descr="no rig description"
  temp="`cat $sdir/gpustemp | awk '$1=$1'`"
  Temp=""
  IFS=$'\r\n' GLOBIGNORE='*' command eval  'TEMPS=($(echo "$temp"))'
  for i in "${TEMPS[@]}"; do
      [ "$i" -ge 0 -a "$i" -le 65 ] && color="black"
      [ "$i" -ge 66 -a "$i" -le 79 ] && color="yellow"
      [ "$i" -ge 80 -a "$i" -le 120 ] && color="red"
      Temp="${Temp} <span class="$color">$i</span>"
  done
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

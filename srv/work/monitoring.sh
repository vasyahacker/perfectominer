#!/bin/bash
todir=$1
iface=$2
#mkdir -p $todir
while true; do
  toplog="`top -bn3 | awk '/^top -/ { p=!p } { if (!p) print }'`"
  echo "$toplog" > $todir/top
  traf="`/work/traffic.sh $2`"
  echo "$traf" > $todir/traf
  tmuxlog="`tmux capture-pane -pS -36 -E -1`"
  echo "$tmuxlog" > $todir/tmuxlog
  nvgputemps="`nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader`"
  amdtemps="`/work/amdtemp.sh`"
  echo "$nvgputemps $amdtemps" > $todir/gpustemp
#  re='(ETH: GPU[0-9]* .*)$'
#  if [[ $tmuxlog =~ $re ]]
#  then
#    echo "${BASH_REMATCH[1]}" > $todir/eth-hashrate
#  fi
done


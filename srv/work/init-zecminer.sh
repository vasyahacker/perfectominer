#!/bin/bash

TODIR="/tmp/zecminer"
GLOBDIR="/work/globals"
mkdir -p $TODIR

ln -s -F /work/zecminer/* $TODIR/

CFG="`cat $TODIR/miner.cfg.tpl`"
RIGID="`cat /mycfg/name`"
TEMPLIMIT="`cat $GLOBDIR/temp-limit`"
ZECPOOL="`cat $GLOBDIR/zec-pool`"
ZECWALLET="`cat $GLOBDIR/zec-wallet`"
zparr=(${ZECPOOL//:/ })
SERVER="${zparr[0]}"
PORT="${zparr[1]}"
USER="$ZECWALLET.$RIGID"
numcudadevs="`cat /mystats/num-cuda-devices`"
DEVICES=""
INTENSITY=""
for ((i=0; i<$numcudadevs; i++))
{
  DEVICES="$DEVICES $i"
  INTENSITY="$INTENSITY 64"
}

re='\{([0-9a-zA-Z\-]+)\}'
while [[ $CFG =~ $re ]]; do
  var="\$${BASH_REMATCH[1]}"
  CFG="${CFG//${BASH_REMATCH[0]}/`eval "echo \"$var\""`}"
done
echo "$CFG" > $TODIR/miner.cfg

echo "cards: $numcudadevs"
tmux new-session -d -s syslog 'exec tailf /var/log/syslog'
tmux split-window "cd $TODIR && ./miner"


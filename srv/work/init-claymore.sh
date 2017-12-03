#!/bin/bash

TODIR="/tmp/claymore"
GLOBDIR="/work/globals"
mkdir -p $TODIR

ln -s -F /work/claymore/* $TODIR/

startscript="`cat $TODIR/start.tpl`"
RIGID="`cat /mycfg/name`"
FAN="`cat $GLOBDIR/fan-speed`"
ETHPOOL="`cat $GLOBDIR/eth-pool`"
ETHWALLET="`cat $GLOBDIR/eth-wallet`"
ETHPASS="`cat $GLOBDIR/eth-pass`"
DCRPOOL="`cat $GLOBDIR/dcr-pool`"
DCRLOGIN="`cat $GLOBDIR/dcr-login`"
DCRPASS="`cat $GLOBDIR/dcr-pass`"
DCRI="`cat $GLOBDIR/dcr-intensive`"
re='\{([0-9a-zA-Z\-]+)\}'
while [[ $startscript =~ $re ]]; do
  var="\$${BASH_REMATCH[1]}"
  startscript="${startscript//${BASH_REMATCH[0]}/`eval "echo \"$var\""`}"
done
echo "$startscript" > $TODIR/start.sh
chmod +x $TODIR/start.sh

tmux new-session -d -s syslog 'exec tailf /var/log/syslog'
tmux split-window "cd $TODIR && ./start.sh"


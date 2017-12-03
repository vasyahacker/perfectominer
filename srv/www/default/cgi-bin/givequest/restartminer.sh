#!/bin/bash
QDIR="/srv/stats/$1/quests"
[ ! -d $QDIR ] && echo "error" && exit 0
FILE=$QDIR/restartminer.sh
coins=`cat /srv/work/ers/$1/coins`

case "$coins" in
  "ETH-DCR")
    mpid=`cat /srv/stats/$1/top |grep ethdcrmine | awk '{print $1;}'`
    cat > $FILE <<- EOF
#!/bin/bash
kill -9 $mpid
sleep 1
tmux split-window "cd /tmp/claymore && ./start.sh"
EOF
chmod +x $FILE
  ;;
  "ZEC") 
     mpid=`cat /srv/stats/$1/top |grep miner | awk '{print $1;}'`
    cat > $FILE <<- EOF
#!/bin/bash
kill -9 $mpid
sleep 1
tmux split-window "cd /tmp/zecminer && ./miner"
EOF
chmod +x $FILE
  ;;
esac



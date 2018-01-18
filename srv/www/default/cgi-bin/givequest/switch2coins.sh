#!/bin/bash
mac=$1
tocoins=$2

QDIR="/srv/stats/$mac/quests"
[ ! -d $QDIR ] && echo "error" && exit 0
FILE=$QDIR/switch2coins.sh
coins=`cat /srv/work/ers/$mac/coins`

[ "$tocoins" == "ZEC" ] && initcmd=/work/init-zecminer.sh
[ "$tocoins" == "VTC" ] && initcmd=/work/init-ccminer.sh
[ "$tocoins" == "ETH-DCR" ] && initcmd=/work/init-claymore.sh


[ "$coins" == "$tocoins" ] && echo "already" && exit 0

case "$coins" in

  "ETH-DCR")
    mpid=`cat /srv/stats/$mac/top |grep ethdcrmine | awk '{print $1;}'`
    
    cat > $FILE <<- EOF
#!/bin/bash
kill -9 $mpid
sleep 2
tmux split-window "$initcmd"
EOF
    chmod +x $FILE
    echo "$tocoins" > /srv/work/ers/$mac/coins
  ;;

  "ZEC") 
    mpid=`cat /srv/stats/$mac/top |grep miner | awk '{print $1;}'`
    cat > $FILE <<- EOF
#!/bin/bash
kill -9 $mpid
sleep 1
tmux split-window "$initcmd"
EOF
    chmod +x $FILE
    echo "$tocoins" > /srv/work/ers/$mac/coins
  ;;

  "VTC") 
    mpid=`cat /srv/stats/$mac/top |grep ccminer | awk '{print $1;}'`
    cat > $FILE <<- EOF
#!/bin/bash
kill -9 $mpid
sleep 1
tmux split-window "$initcmd"
EOF
    chmod +x $FILE
    echo "$tocoins" > /srv/work/ers/$mac/coins
  ;;
esac



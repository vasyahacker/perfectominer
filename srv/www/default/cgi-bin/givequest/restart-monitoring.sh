#!/bin/bash
[ ! -d /srv/stats/$1/quests ] && echo "error" && exit 0

FILE=/srv/stats/$1/quests/restart-monitoring.sh
cat > $FILE <<- EOF
#!/bin/bash
#monpid="`ps ax | grep monitoring.sh | awk '{print $1;}'`"
killall monitoring.sh
#/work/monitoring.sh >/dev/null 2>&1 &
EOF
chmod +x $FILE

#!/bin/bash
[ ! -d /srv/stats/$1/quests ] && echo "error" && exit 0
FILE=/srv/stats/$1/quests/shutdown
cat > $FILE <<- EOF
#!/bin/bash
echo "Shutdown.."
rm -f /myquests/shutdown
touch /work/stats/$1/offline
shutdown -h now 
EOF
chmod +x $FILE

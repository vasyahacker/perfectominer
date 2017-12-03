#!/bin/bash
[ ! -d /srv/stats/$1/quests ] && echo "error" && exit 0
FILE=/srv/stats/$1/quests/reboot
cat > $FILE <<- EOF
#!/bin/bash
echo "Rebooting.."
rm -f /myquests/reboot
touch /work/stats/$1/offline
#shutdown -r now
echo 1 > /proc/sys/kernel/sysrq 
echo b > /proc/sysrq-trigger 
EOF
chmod +x $FILE

#!/bin/bash
[ ! -d /srv/stats/$1/quests ] && echo "error" && exit 0
FILE=/srv/stats/$1/quests/reboot
cat > $FILE <<- EOF
#!/bin/bash
rbt(){
	umount -l -k /work/stats
	#shutdown -r now
	sleep 1
	echo 1 > /proc/sys/kernel/sysrq 
	echo b > /proc/sysrq-trigger
}
echo "Rebooting.."
touch /work/stats/$1/offline
sync
#rm -f /myquests/reboot
rbt >/dev/null 2>&1 &
EOF
chmod +x $FILE
touch /srv/stats/$1/reboot_flag


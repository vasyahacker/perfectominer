#!/bin/sh -e
/srv/reset_buttons.sh > /dev/null 2>&1 &
service nfs-kernel-server restart
echo "1"> /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE

cd /srv/www && socat -lf /dev/null TCP4-LISTEN:80,fork EXEC:./webserver.sh>/dev/null &

#`cd /srv/eth-proxy && ./eth-proxy.py > /dev/null 2>&1 &`
/srv/monitoring.sh > /dev/null 2>&1 &


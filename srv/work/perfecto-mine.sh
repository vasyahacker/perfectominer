#!/bin/bash
ifname=`route | grep '^default' | grep -o '[^ ]*$'`
MAC=`cat /sys/class/net/$ifname/address`
SERV_IP="10.9.8.1"
IP=`ifconfig $ifname 2>/dev/null | awk '/inet addr:/ {print $2}'|sed 's/addr://'`
mac="${MAC//:}"
mydir="/work/ers/$mac"
sdir=/work/stats/$mac
DEFAULT_TZ="Europe/Moscow"

/etc/init.d/lightdm stop

echo "Cheking my working dir..."
if [ ! -d "$mydir" ]; then
   mkdir -p $mydir
   mynum=`ls -1 /work/ers | wc -l`
   echo "rig`printf "%02d\n" $mynum`" > $mydir/name
   echo "Setup GPIO pin..."
   mygpio=`sed "${mynum}q;d" /work/globals/gpio-list`
   echo "$mygpio" > $mydir/gpio
else
   mygpio=`cat $mydir/gpio`
fi
echo "My GPIO pin is $mygpio"

ln -s -F $mydir /mycfg
ln -s -F $sdir /mystats

echo "Setup root password"
passfile="$mydir/pass"
[ -f $passfile ] && password="`cat $passfile`" || password="`cat /work/globals/password`"; echo "$password" > $passfile
echo -e "$password\n$password" | passwd root > /dev/null 2>&1

[ -f /work/globals/timezone ] && TZ="`cat /work/globals/timezone`" || TZ=$DEFAULT_TZ
echo "Set timezone to $TZ"
timedatectl set-timezone $TZ

echo "Setup hostname..."
namepath="$mydir/name" 
if [ -f $namepath ]; then
  hostname="`cat $namepath`"
else
  echo "$mac">$namepath
  hostname=$mac
fi
/work/set_hostname.sh $hostname
echo "My hostname is $hostname"

echo "Setup stat dir..."
mount.nfs $SERV_IP:/srv/stats /work/stats
[ ! -d "$sdir" ] && mkdir -p $sdir

rm -f $sdir/offline

echo "Checking cards vendor... "
/work/check-vendor.sh

echo "Sending my hardware info to boss"
lshw > $mydir/lshw
/work/monitoring.sh $sdir $ifname >/dev/null &

echo "My IP is $IP"
echo "$IP" > $sdir/ip

echo "Starting quest daemon..."
qdir="$sdir/quests"
mkdir -p $qdir
ln -s -F $qdir /myquests
/work/get_quest.sh > /dev/null &


echo "Set fans speed and overclocking..."
/work/overclock.sh >$sdir/overclock.log 2>&1 &

echo "Starting  miner..."
/work/select-miner.sh

echo "`date`" >> $qdir/log
echo "Started!" >> $qdir/log

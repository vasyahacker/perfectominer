#!/bin/bash

echo -e "\e[32madd mount points to fstab...\e[0m";
if grep -Fq "/srv/stats" /etc/fstab
then
  echo "already exists, skipping.."
else
  echo 'tmpfs    /srv/stats    tmpfs    defaults,noatime,nosuid,size=18m    0 0' >> /etc/fstab
  mount /srv/stats
fi

echo -e "\e[32madd init script to rc.local...\e[0m";
if grep -Fq "/srv/init.sh" /etc/rc.local
then
  echo "already exists, skipping.."
else
  sed -i -e '$i \nohup sh /srv/init.sh > /dev/null 2>&1 &\n' /etc/rc.local
fi

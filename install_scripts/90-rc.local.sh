#!/bin/bash

echo -e "\e[32madd init script to rc.local...\e[0m";
if grep -Fq "/srv/init.sh" /etc/rc.local
then
  echo "already exists, skipping.."
else
  sed -i -e '$i \nohup sh /srv/init.sh > /dev/null 2>&1 &\n' /etc/rc.local
fi

if pgrep -x "/srv/init.sh" > /dev/null
then
  nohup sh /srv/init.sh > /dev/null 2>&1 &
  echo "/srv/init.sh already running"
else
  echo "Running perfecto initialization script.."
fi

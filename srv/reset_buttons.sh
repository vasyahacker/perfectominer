#!/bin/bash

for gf in /srv/work/ers/*/gpio
do
  gpio="`cat $gf`"
  echo "$gpio" > /sys/class/gpio/export
  echo "out" > /sys/class/gpio/gpio$gpio/direction
  echo "1" > /sys/class/gpio/gpio$gpio/value
  sleep 1
  echo "0" > /sys/class/gpio/gpio$gpio/value
done


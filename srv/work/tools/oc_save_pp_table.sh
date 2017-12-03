#!/bin/bash

x=0
while [ $x -le 14 ]; do
    if [ -e "/sys/class/drm/card$x/device/pp_table" ]
    then
        mkdir /var/tmp/pp_tables
        mkdir /var/tmp/pp_tables/gpu$x
        cp /sys/class/drm/card$x/device/pp_table /var/tmp/pp_tables/gpu$x/pp_table
    fi
    x=$[x + 1]
done


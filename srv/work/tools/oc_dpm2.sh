#!/bin/bash

#CONFIG_FILE="/root/config.txt"
#source $CONFIG_FILE
MINER_POWERLIMIT=5
coreState="7"
clocks="$1"
memorys="$2"
coreArray=()
memoryArray=()
for i in $(echo $clocks | sed "s/,/ /g")
do
    coreArray+=($i)
done
for i in $(echo $memorys | sed "s/,/ /g")
do
    memoryArray+=($i)
done


if [ "$MINER_POWERLIMIT" -ge "0" ] && [ "$MINER_POWERLIMIT" -le "7" ]; then
    coreState=$MINER_POWERLIMIT
fi


i=0;
j=0;
x=0;
while [ $x -le 14 ]; do
    if [ -e "/sys/class/drm/card$x/device/pp_table" ]
    then

        if [ ! -e "/var/tmp/pp_tables/gpu$x/pp_table" ]
        then
            echo "ERROR OC GPU$x, you need to reboot rig this time to get this working !!!"
            break
        fi

        if [ "${coreArray[$i]}" -ge "300" ] && [ "${coreArray[$i]}" -le "1500" ] && [ "${memoryArray[$j]}" -ge "300" ] && [ "${memoryArray[$j]}" -le "3000" ]; then
            echo "GPU$x:"
        else
            echo "Invalid OC values: core${coreArray[$i]} memory:${memoryArray[$j]} , skipping OC"
        exit
        fi
        cp /var/tmp/pp_tables/gpu$x/pp_table /sys/class/drm/card$x/device/pp_table
        sleep 0.1
        mem_states=`cat /sys/class/drm/card$x/device/pp_dpm_mclk | wc -l`
        memoryState=$(($mem_states-1))
        /work/tools/wolfamdctrl -i $x --core-state $coreState --mem-state $memoryState --core-clock ${coreArray[$i]} --mem-clock ${memoryArray[$j]}
        sleep 0.1
        echo manual > /sys/class/drm/card$x/device/power_dpm_force_performance_level
        echo $coreState > /sys/class/drm/card$x/device/pp_dpm_sclk
        echo $memoryState > /sys/class/drm/card$x/device/pp_dpm_mclk
        # sprawdza czy nastepny element wpisany przez usera jest poprawny, jezeli nie to zostawia poprzednie na nastepne karty
        if [ "${coreArray[$i+1]}" -eq "${coreArray[$i+1]}" ] 2>/dev/null
        then
            i=$[i + 1]
        fi

        if [ "${memoryArray[$j+1]}" -eq "${memoryArray[$j+1]}" ] 2>/dev/null
        then
            j=$[j + 1]
        fi

    fi
    x=$[x + 1]
done

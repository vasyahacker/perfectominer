#!/bin/bash
[ ! -d /sys/class/drm/card0/device/hwmon ] && exit 0;
ls -1 /sys/class/drm/card*/device/hwmon/hwmon*/pwm1 | while read hwmon; do
  TEMP1_INPUT=`echo $hwmon | sed -e "s/pwm1/temp1_input/"`;
  CARD_BASE_PATH=`echo $hwmon | head -c 28`;
  CARD_GPU_CLOCK=`cat "$CARD_BASE_PATH/pp_dpm_sclk" | tail -n 1 | awk {'print $2'} | head -c 4`;
  CARD_MEM_CLOCK=`cat "$CARD_BASE_PATH/pp_dpm_mclk" | tail -n 1 | awk {'print $2'} | head -c 4`;
  NAME=`echo $hwmon | cut -d / -f 5 | sed -e "s/card/GPU #/"`;
  FAN=`cat $hwmon`;
  TEMP1=`cat $TEMP1_INPUT`;
  TMP=$(($TEMP1/1000));
  echo "$TMP"
done

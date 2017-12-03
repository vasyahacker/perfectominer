#!/bin/bash
export DISPLAY=:0

NS="nvidia-settings"
NUM_CARDS="`cat /mystats/num-cuda-devices`"

for ((i=0; i<$NUM_CARDS; i++))
{
  [ ! -e /mycfg/nv-fan$i-speed ] && cp /work/globals/fan-speed /mycfg/nv-fan$i-speed
  fan=`cat /mycfg/nv-fan$i-speed`
  [ "$fan" = "0" ] &&  $NS -a [gpu:$i]/GPUFanControlState=0 || $NS -a [gpu:$i]/GPUFanControlState=1 -a [fan:$i]/GPUTargetFanSpeed=$fan 
  
  [ ! -e /mycfg/nv-gpu$i-overclock ] && cp /work/globals/nv-gpu-overclock /mycfg/nv-gpu$i-overclock
  [ ! -e /mycfg/nv-mem$i-overclock ] && cp /work/globals/nv-mem-overclock /mycfg/nv-mem$i-overclock
  gpu="`cat /mycfg/nv-gpu$i-overclock`"
  mem="`cat /mycfg/nv-mem$i-overclock`"
  $NS -a [gpu:$i]/GPUPowerMizerMode=1
  $NS -a [gpu:$i]/GPUGraphicsClockOffset[3]=$gpu
  $NS -a [gpu:$i]/GPUMemoryTransferRateOffset[3]=$mem
}


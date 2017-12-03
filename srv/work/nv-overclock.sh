#!/bin/bash
nvidia-xconfig --enable-all-gpus --separate-x-screens --allow-empty-initial-configuration
nvidia-xconfig --cool-bits=12
nohup /usr/bin/X :0 2>&1 &
sleep 5
export DISPLAY=:0

CARDS="`nvidia-smi --query-gpu=name --format=csv,noheader`" 
cards_f="/mycfg/cards"
[ -e $cards_f ] || echo "$CARDS" > $cards_f
[ "$CARDS" = "`cat $cards_f`" ] || echo "$CARDS" > $cards_f

NUM_CARDS="`echo "$CARDS" | wc -l`"
 echo "$NUM_CARDS" > /mystats/num-cuda-devices

/work/nv-reoverclock.sh


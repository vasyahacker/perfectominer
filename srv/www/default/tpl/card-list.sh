#!/bin/bash
MAC=$1
card="`cat tpl/card-item.tpl`"
card="${card//\{/\$\{}"
wdir="/srv/work/ers/$MAC"
cards="`cat $wdir/cards`"
id=0
while read -r card_name
do
  fan="`cat $wdir/nv-fan$id-speed`"
  gpu="`cat $wdir/nv-gpu$id-overclock`"
  mem="`cat $wdir/nv-mem$id-overclock`"

  eval "echo \"$card\""
	((id++)) 
done <<< "$cards"

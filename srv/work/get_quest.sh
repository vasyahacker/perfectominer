#!/bin/bash
d="/myquests"
log=$d/log
while true; do
  QUESTS=`ls -1 $d`
  for quest in $QUESTS; do
    if [ -x "$d/$quest" ]; then
      echo `date` >> $log
      $d/$quest >> $log
     rm -f $d/$quest
    fi
  done
  sleep 1
done

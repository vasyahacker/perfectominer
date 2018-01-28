#!/bin/bash
urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }
IN="$1"
arrIN=(${IN//&/ })
wdir=/srv/work/ers/${arrIN[0]}
descr=`urldecode "${arrIN[1]}"`
[ -e $wdir ] && echo "$descr" > $wdir/descr
echo $wdir
echo 
echo $descr

#!/bin/bash
tfile=/srv/stats/$1/gpustemp
[ ! -f $tfile ] && echo "error" && exit 0
cat $tfile

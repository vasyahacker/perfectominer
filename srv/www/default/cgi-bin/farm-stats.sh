#!/bin/bash
#[ ! -d /srv/stats/$1/quests ] && echo "offline" && exit 0
ID=$1
HTML="`cat tpl/farm-stats.tpl`"
HTML="${HTML//\{/\$\{}"
sdir="/srv/stats/$ID"
top="`cat $sdir/top`"
traf="`cat $sdir/traf`"
gpustemp="`cat $sdir/gpustemp`"
currency="`cat /srv/work/ers/$ID/coins`"
vendor="`cat /srv/work/ers/$ID/vendor`"
eval "echo \"$HTML\""

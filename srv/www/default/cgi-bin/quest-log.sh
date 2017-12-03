sdir="/srv/stats/$1/quests"
[ ! -d $sdir ] && echo "error" && exit 0
echo "<pre>"
tail -n 54 $sdir/log
echo "</pre>"

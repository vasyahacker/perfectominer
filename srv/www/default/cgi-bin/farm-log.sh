sdir="/srv/stats/$1/quests"
[ ! -d $sdir ] && echo "error" && exit 0
echo "<pre>"
tail -n 18 /srv/stats/$1/tmuxlog
echo "</pre>"

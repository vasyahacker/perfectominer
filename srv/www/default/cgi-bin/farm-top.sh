sdir="/srv/stats/$1"
[ ! -d $sdir ] && echo "error" && exit 0
echo "<pre>"
cat /srv/stats/$1/top
echo "</pre>"

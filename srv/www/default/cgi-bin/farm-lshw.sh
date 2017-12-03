wdir="/srv/work/ers/$1"
[ ! -d $wdir ] && echo "error" && exit 0
echo "<pre>"
cat $wdir/lshw
echo "</pre>"
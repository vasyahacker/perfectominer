#!/bin/bash
#[ ! -d /srv/stats/$1/quests ] && echo "error" && exit 0
saveIFS=$IFS
IFS='=&'
parm=($@)
IFS=$saveIFS
mac="${parm[1]}"
wdir=/srv/work/ers/$mac
for ((i=0; i<${#parm[@]}; i+=2))
do
   [ $i -ge 2 ] && echo "${parm[i+1]}" > $wdir/${parm[i]}
done
FILE=/srv/stats/$mac/quests/reoverclock.sh
cat > $FILE <<- EOF
#!/bin/bash
/work/nv-reoverclock.sh
EOF
chmod +x $FILE

#!/bin/bash
[ ! -d /srv/stats/$1/quests ] && echo "error" && exit 0
FILE=/srv/stats/$1/quests/passwd.sh
cat > $FILE <<- EOF
#!/bin/bash
echo "set root password"
echo -e "$2\n$2" | passwd root > /dev/null 2>1
EOF
chmod +x $FILE


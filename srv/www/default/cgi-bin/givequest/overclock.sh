#!/bin/bash
[ ! -d /srv/stats/$1/quests ] && echo "error" && exit 0
FILE=/srv/stats/$1/quests/tmuxlog.sh
cat > $FILE <<- EOF
#!/bin/bash
/work/tools/oc_save_pp_table.sh
#/work/tools/oc_dpm2.sh 1230 2166  #overdoze
/work/tools/oc_dpm2.sh 1190 2100  
EOF
chmod +x $FILE
/srv/www/default/cgi-bin/givequest/restartminer.sh $1


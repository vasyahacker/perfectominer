#!/bin/bash

SERVER_NAME="`cat /etc/hostname`"
TIME=`date +%Y-%b-%d`
GPG_COMMAND="gpg -c -z 0 --batch --passphrase 123"
FS_FILE=/srv/$SERVER_NAME-fs.$TIME.tar.gz


# Archiving filesystem
#tar -cz /etc /root /home /media /srv/work  | $GPG_COMMAND > $FS_FILE
tar -cz /etc /root /home /srv/www /srv/work /srv/*.sh /srv/tftp/menu-* > $FS_FILE
cat /srv/bupass | gpg --passphrase-fd 0 -c $FS_FILE
# Uploading to the cloud
curl -k --user `cat /srv/yapass` -T "$FS_FILE.gpg" https://webdav.yandex.ru/rpi/
# Cleanup
unlink $FS_FILE
unlink $FS_FILE.gpg

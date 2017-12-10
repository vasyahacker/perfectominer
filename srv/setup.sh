#!/bin/bash
scripts=/srv/install_scripts/*.sh
for script in $scripts; do
  [ -x $script ] && $script &&  chmod -x $script
done
#
sudo sync

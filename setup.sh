#!/bin/bash
. ./install_scripts/.perfectolib.sh
scripts=./install_scripts/*.sh
for script in $scripts; do
  [ -x $script ] && {
  	yN ans "Run $script?"
  	[ "$ans" == "y" ] && $script #&& chmod -x $script
  }
done
#
sudo sync

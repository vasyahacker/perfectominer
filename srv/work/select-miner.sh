#!/bin/bash

[ ! -f /mycfg/coins ] && cp /work/globals/coins /mycfg/

coins="`cat /mycfg/coins`"

case "$coins" in
  "ETH-DCR") /work/init-claymore.sh ;;
  "ZEC") /work/init-zecminer.sh ;;
esac

#!/bin/bash
. .perfectolib.sh
set_global()
{
  dir=/srv/work/globals1
  [ -e $dir/$2 ] && { 
    yN ans "$dir/$2 already exists, set new value?"
    [ "$ans" == "n" ] && return
  }
  printf "${CGR}$1${NC}: "
  read text
  echo "set '$text' to $dir/$2"
  echo "$text" > $dir/$2
}

set_global "Default coins (ZEC or ETH-DCR)" "coins"

set_global "Decred intesivity for claymore (27)" "dcr-intensive"
set_global "Decred pool login" "dcr-login"
set_global "Decred worker password" "dcr-pass"
set_global "Decred pool (stratum+tcp://address:port)" "dcr-pool"

set_global "Eth wallet" "eth-wallet"
set_global "Eth worker password" "eth-pass"
set_global "Eth pool (address:port)" "eth-pool"

set_global "Zec wallet" "zec-wallet"
set_global "Zec pool (address:port)" "zec-pool"

set_global "Default fan speed 0-100 (0=auto)" "fan-speed"
set_global "Default nvidia gpu overclock (0-200)" "nv-gpu-overclock"
set_global "Default nvidia mem overclock (0-2000)" "nv-mem-overclock"
set_global "Default rig root password" "password"
set_global "Default temp limit (80)" "temp-limit"
set_global "Time zone (Europe/Moscow)" "timezone"
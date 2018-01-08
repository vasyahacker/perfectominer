#!/bin/bash
. .perfectolib.sh

echo "Getting latest iso image perfecto linux.."

local_iso=/srv/tftp/iso/perfecto1.iso
iso_md5=/srv/tftp/iso/perfecto.md5
ipns="QmS5FarZ3YLD86JErdGbuKyfZvHBPCLiVYHLkYPKMdBpc7"
ipfs_link="https://gateway.ipfs.io/ipns/$ipns"
iso_link="$ipfs_link/perfecto.iso"
md5_link="$ipfs_link/perfecto.md5"

[ -e $local_iso ] && {
  Yn ans "$local_iso already exists, remove and download last image version now?"
  [ "$ans" ==  "n" ] && return
  rm -f $local_iso
}
wget -O $iso_md5 $md5_link
wget -O $local_iso -c -t0 $iso_link

echo "Downloads complete, сhecking md5 of iso..."


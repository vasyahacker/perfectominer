#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $DIR/.perfectolib.sh
#tdir=/tmp/btfs
local_iso=/srv/tftp/iso/perfecto.iso
iso_md5=/srv/tftp/iso/perfecto.md5
iso_link="https://yadi.sk/d/ozj8wjhz3RdFsF"
md5_link="https://yadi.sk/d/aJwdao_T3RdKhX"
#[ -e $local_iso ] && {
#  Yn ans "$local_iso already exists, remove and download last image version now?"
#  [ "$ans" ==  "y" ] && rm -f $local_iso
#}

#printf "Mount btfs perfecto torrent to $tdir"
#mkdir -p $tdir
#btfs "magnet:?xt=urn:btih:3B46A5136C285C922C3EBB45B8F335F7B1C74C40&dn=perfecto&tr=http%3a%2f%2fopen.tracker.thepiratebay.org%2fannounce" $tdir
#while [ -z "$(ls -A $tdir)" ]; do sleep 1 && printf "."; done
echo
printf "Getting latest iso image perfecto linux.."
saveto "$iso_link" "$local_iso"
printf "Getting md5 of iso.."
saveto "$md5_link" "$iso_md5"
#ipns="QmS5FarZ3YLD86JErdGbuKyfZvHBPCLiVYHLkYPKMdBpc7"
#ipfs_link="https://gateway.ipfs.io/ipns/$ipns"
#ipfs_link="/ipns/$ipns"
#iso_link="$ipfs_link/iso/perfecto.iso"
#md5_link="$ipfs_link/perfecto.md5"


#bar -if $tdir/perfecto/iso/perfecto.iso -of $local_iso
#pv $tdir/perfecto/iso/perfecto.iso > $local_iso

#ipget -o $local_iso $md5_link
#ipget -o $local_iso $iso_link

printf "Downloads complete, сhecking md5 of iso..."
md5hash=`md5sum $local_iso | awk '{print $1}'`
[ "$md5hash" == "`cat $iso_md5`" ] || printf "[${CRE}check md5 error${NC}]\n" && {
	printf "[${CGR}Ok${NC}]\n"
	echo -e "\e[32madd mount points to fstab...\e[0m";

	if grep -Fq "/srv/tftp/nfs/perfecto" /etc/fstab
	then
	  echo "iso point already exists, skipping.."
	else
	  echo '/srv/tftp/iso/perfecto.iso  /srv/tftp/nfs/perfecto  auto  loop,ro  0  0' >> /etc/fstab
	fi
	mount -v /srv/tftp/nfs/perfecto

	if grep -Fq "/srv/stats" /etc/fstab
	then
	  echo "stats point already exists, skipping.."
	else
	  echo 'tmpfs    /srv/stats    tmpfs    defaults,noatime,nosuid,size=18m    0 0' >> /etc/fstab
	fi
	mount -v /srv/stats
}
#umount $tdir

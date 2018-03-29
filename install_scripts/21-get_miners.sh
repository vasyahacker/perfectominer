#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $DIR/.perfectolib.sh
local_bin=/tmp/zecminer.tar.gz
local_md5=/tmp/zecminer.md5
bin_link="https://yadi.sk/d/SpLCX3yT3Rdk9K"
md5_link="https://yadi.sk/d/rFdpQa713Rdk9A"
printf "Getting zec miner.."
saveto "$bin_link" "$local_bin"
saveto "$md5_link" "$local_md5"
printf "Downloads complete, сhecking md5.."
md5hash=`md5sum $local_bin | awk '{print $1}'`
[ "$md5hash" == "`cat $local_md5`" ] || printf "[${CRE}error md5 check${NC}]\n" && {
	 printf "[${CGR}OK${NC}]\n"
	(cd /tmp && tar xzvf $local_bin && cp -vf /tmp/0.3.4b/miner /srv/work/zecminer/ && rm -rf /tmp/0.3.4b)
}
rm $local_bin $local_md5

local_bin=/tmp/claymore.tar.gz
local_md5=/tmp/claymore.md5
bin_link="https://yadi.sk/d/l_AMet0N3Truoy"
fol_name="Claymore's Dual Ethereum+Decred_Siacoin_Lbry_Pascal_Blake2s_Keccak AMD+NVIDIA GPU Miner v11.5 - LINUX"
md5_link="https://yadi.sk/d/P1yDHID83TruoH"
printf "Getting $fol_name.."
saveto "$bin_link" "$local_bin"
saveto "$md5_link" "$local_md5"
printf "Downloads complete, сhecking md5.."
md5hash=`md5sum $local_bin | awk '{print $1}'`
[ "$md5hash" == "`cat $local_md5`" ] || printf "[${CRE}error md5 check${NC}]\n" && {
	 printf "[${CGR}OK${NC}]\n"
	(cd /tmp && tar xzvf $local_bin && cd "$fol_name" && cp -f ./* /srv/work/claymore/ && rm -rf "/tmp/$fol_name")
}
rm $local_bin $local_md5


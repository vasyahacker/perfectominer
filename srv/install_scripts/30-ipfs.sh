#!/bin/bash
exit
echo -e "\e[32minstall ipfs...\e[0m";
( cd \
&& wget https://dist.ipfs.io/ipfs-update/v1.5.2/ipfs-update_v1.5.2_linux-arm.tar.gz \
&& tar xzf ipfs-update_v1.5.2_linux-arm.tar.gz \
&& cd ipfs-update && sudo ./install.sh \
&& cd .. && rm -rf ipfs-update \
&& rm ipfs-update_v1.5.2_linux-arm.tar.gz \
&& wget https://dist.ipfs.io/ipget/v0.3.0/ipget_v0.3.0_linux-arm.tar.gz \
&& tar xzf ipget_v0.3.0_linux-arm.tar.gz \
&& cd ipget && sudo cp ./ipget /usr/local/bin \
&& cd .. && rm -rf ipget \
&& rm ipget_v0.3.0_linux-arm.tar.gz \
)
#sudo ipfs-update install v0.4.13
#echo "Please, after install, check /tmp for *.tar.gz and delete"
#

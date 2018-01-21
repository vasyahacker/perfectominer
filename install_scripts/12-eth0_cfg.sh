#!/bin/bash
echo -e "\e[32mconfigure eth0...\e[0m";
sudo cat << EOT > /etc/network/interfaces.d/eth0

auto eth0
iface eth0 inet static
	address 10.9.8.1
	netmask 255.255.255.0

EOT
sudo /etc/init.d/networking restart


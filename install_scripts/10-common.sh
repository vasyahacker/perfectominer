#!/bin/bash
#echo -e "\e[32minstall common packages...\e[0m";
#sudo update-rc.d ssh defaults
sudo apt install -y socat
sudo apt remove -y triggerhappy bluez
sudo apt autoremove -y

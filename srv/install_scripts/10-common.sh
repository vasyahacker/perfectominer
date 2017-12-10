#!/bin/bash
echo -e "\e[32minstall common packages...\e[0m";
sudo apt-get -y install git;
sudo update-rc.d ssh defaults

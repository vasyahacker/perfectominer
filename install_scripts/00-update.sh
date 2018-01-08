#!/bin/bash
sudo sync \
&& echo -e "\e[32mupdate...\e[0m" && sudo apt-get -y update \
&& echo -e "\e[32mupgrade...\e[0m" && sudo apt-get -y upgrade \
&& echo -e "\e[32mautoremove...\e[0m" && sudo apt-get -y --purge autoremove \
&& echo -e "\e[32mautoclean...\e[0m" && sudo apt-get autoclean \
&& echo -e "\e[32mDone.\e[0m" \
&& sudo sync


#!/bin/bash
echo -e "\e[32minstall perfecto scripts...\e[0m";
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
sudo cp -r $DIR/../srv /

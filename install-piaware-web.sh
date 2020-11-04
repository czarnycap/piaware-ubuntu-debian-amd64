#!/bin/bash

INSTALL_DIRECTORY=${PWD}

echo -e "\e[32mUpdating\e[39m"
sudo apt update
echo -e "\e[32mInstalling build tools\e[39m"
sudo apt install -y git debhelper dh-systemd

echo -e "\e[32mCloning piaware-web source code \e[39m"
cd  ${INSTALL_DIRECTORY}
git clone https://github.com/flightaware/piaware-web 
echo -e "\e[32mbuilding piaware-web package \e[39m"
cd  ${INSTALL_DIRECTORY}/piaware-web
./prepare-build.sh buster 
cd package-buster
sudo dpkg-buildpackage -b --no-sign
echo -e "\e[32mInstalling piaware-web package \e[39m"
cd ../
sudo dpkg -i piaware-web_4.0_all.deb

sudo systemctl enable piaware-web
sudo systemctl restart piaware-web

echo ""
echo -e "\e[32mPIAWARE-WEB INSTALLATION COMPLETED \e[39m"
echo ""
echo -e "\e[32mIn your browser, go to web interface at\e[39m"
echo -e "\e[39m     $(ip route | grep -m1 -o -P 'src \K[0-9,.]*') \e[39m"
echo -e "\e[32m     OR\e[39m"
echo -e "\e[39m     $(ip route | grep -m1 -o -P 'src \K[0-9,.]*'):80 \e[39m"
echo ""
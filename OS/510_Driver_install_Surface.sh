#!/bin/bash

echo
tput setaf 2
echo "####################################################"
echo "#########   Install Surface Pro Drivers   ##########"
echo "####################################################"
tput sgr0
echo

sudo pacman -S --noconfirm --needed iio-sensor-proxy

sudo pikaur -S --noconfirm --needed kded-rotation-git detect-tablet-mode-git tablet-mode

echo
tput setaf 2
echo "##############################################"
echo "##################  DONE   ###################"
echo "##############################################"
tput sgr0
echo

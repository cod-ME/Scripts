#!/bin/bash

echo
tput setaf 2
echo "####################################################"
echo "##########   Install Coding essentials   ###########"
echo "####################################################"
tput sgr0
echo

sudo pacman -S --noconfirm --needed vscodium kate neovim

echo
tput setaf 2
echo "##############################################"
echo "##################  DONE   ###################"
echo "##############################################"
tput sgr0
echo

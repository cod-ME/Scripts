#!/bin/bash

echo
tput setaf 2
echo "####################################################"
echo "##########   Install Coding essentials   ###########"
echo "####################################################"
tput sgr0
echo

sudo pacman -S --noconfirm --needed visual-studio-code-bin

echo
tput setaf 2
echo "##############################################"
echo "##################  DONE   ###################"
echo "##############################################"
tput sgr0
echo

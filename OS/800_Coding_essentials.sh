#!/bin/bash

echo
tput setaf 2
echo "####################################################"
echo "##########   Install Coding essentials   ###########"
echo "####################################################"
tput sgr0
echo

sudo pacman -S --noconfirm --needed vscodium vscodium-marketplace kate neovim wget anaconda

mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh

~/miniconda3/bin/conda init bash
~/miniconda3/bin/conda init zsh
echo
tput setaf 2
echo "##############################################"
echo "##################  DONE   ###################"
echo "##############################################"
tput sgr0
echo

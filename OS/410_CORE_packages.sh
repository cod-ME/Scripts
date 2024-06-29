#! /bin/bash
echo
tput setaf 2
echo "################################################"
echo "##############  CORE Packages   ################"
echo "################################################"
tput sgr0
echo

sudo pacman -S --noconfirm --needed  nemo nemo-audio-tab nemo-emblems nemo-fileroller nemo-image-converter nemo-pastebin nemo-preview nemo-python nemo-seahorse nemo-share nemo-terminal nemo-theme-glacier xfce4-terminal


sudo pacman -S --noconfirm --needed kitty btop firefox feh noto-fonts-emoji fastfetch pokemon-colorscripts

tput setaf 2
echo "################################################"
echo "##################  DONE   #####################"
echo "################################################"
tput sgr0
echo

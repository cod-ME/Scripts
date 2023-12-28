#! /bin/bash
echo
tput setaf 2
echo "##############################################"
echo "###############   SURFACE PRO 7+   ################"
echo "##############################################"
tput sgr0
echo

sudo pacman -Syy --noconfirm --needed linux-surface linux-surface-headers iptsd linux-firmware-marvell linux-surface-secureboot-mok

echo
tput setaf 2
echo "##############################################"
echo "####################  DONE   ####################"
echo "##############################################"
tput sgr0
echo

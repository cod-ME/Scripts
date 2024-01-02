#! /bin/bash
#

#Erik key
sudo pacman-key --lsign-key 74F5DE85A506BF64

sudo pacman -Syy --noconfirm --needed arcolinux-mirrorlist-git arcolinux-keyring

echo
tput setaf 2
echo "#############################################################"
echo "###########   Please edit /etc/pacman.conf   ################"
echo "########   Change SigLevel = Optional TrustAll   ############"
echo "########   to SigLevel = Optional TrustedOnly    ############"
echo "###   for [arcolinux_repo] and [arcolinux_repo_3prarty]   ###"
echo "#############################################################"
tput sgr0
echo

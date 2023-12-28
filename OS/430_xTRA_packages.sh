#!/bin/bash

echo "########  Installing xTRA packages  #######"

sudo pacman -S --noconfirm --needed firedragon librewolf brave-bin mullvad-browser-bin chromium vivaldi
sudo pacman -S --noconfirm --needed thunderbird spotify-adblock-git freetube keepassxc stacer bottles hypnotix
sudo pacman -S --noconfirm --needed visual-studio-code-bin

echo "#############  DONE   ###############"

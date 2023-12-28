#!/bin/bash

sudo pacman -S --noconfirm --needed git
cd ~
git clone https://github.com/JaKooLit/Arch-Hyprland.git
cd Arch-Hyprland
chmod +x install.sh
./install.sh

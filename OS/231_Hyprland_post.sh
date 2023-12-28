#!/bin/bash

echo "######   Coping Hyprland config  #######"
# Target folder to be copied
TARGET_FOLDER="$(dirname "$(realpath "$0")")/way_dotfiles/Hyprland"
# Path of destination folder
DESTINATION_FOLDER="$HOME/.config/"
cp -R "${source_dir}/$TARGET_FOLDER"/* $DESTINATION_FOLDER

echo "########  Installing Themes  ##########"
pikaur -S --needed eww-wayland rofi-lbonn-wayland dunst trayer mpvpaper macchina nitch nerd-fonts-inter socat geticons
sudo usermod -aG video $USER
sudo usermod -aG input $USER

theme() {
cd ~
git clone --recursive https://github.com/Aylur/ags.git
cd ags
npm install
meson setup build
meson install -C build
cd ..
rm -rf ags
}

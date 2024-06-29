#!/bin/bash

echo "######   Coping Hyprland config  #######"
# get clone theme/config files
git clone https://github.com/cod-ME/ME_dotfiles.git

# Path of destination folder
DESTINATION_FOLDER="$HOME/.config/"
# # Define the base source directory
TARGET_FOLDER="$(dirname "$(realpath "$0")")/ME_dotfiles/Hyprland"
# # List of target folders to be copied
# TARGET_FOLDERS=("Hyprland" "Folder1" "Folder2" "Folder3")

# # Loop through each target folder and copy its contents to the destination folder
# for folder in "${TARGET_FOLDERS[@]}"; do
#   SOURCE_DIR="$BASE_SOURCE_DIR/$folder"
#   cp -R "${SOURCE_DIR}/" "$DESTINATION_FOLDER"
# done

# Path of destination folder
DESTINATION_FOLDER="$HOME/.config/"
cp -R "$TARGET_FOLDER"/* $DESTINATION_FOLDER
DESTINATION_FOLDER="$HOME/.cache/"
cp -R "$TARGET_FOLDER/wal" $DESTINATION_FOLDER

echo "########  Installing Themes  ##########"
pikaur -S --needed trayer mpvpaper nitch nerd-fonts-inter geticons python-pywal
sudo usermod -aG video $USER
sudo usermod -aG input $USER

echo
tput setaf 2
echo "####################  Installing Hyprland Plugins   ####################"
tput sgr0
echo

hyprpm add https://github.com/horriblename/hyprgrass
hyprpm enable hyprgrass
hyprpm add https://github.com/shezdy/hyprsplit
hyprpm enable hyprsplit

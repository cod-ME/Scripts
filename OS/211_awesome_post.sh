#!/bin/bash

echo "######   Coping AwesomeWM config  #######"
# Target folder to be copied
TARGET_FOLDER="$(dirname "$(realpath "$0")")/awesome"
# Path of destination folder
DESTINATION_FOLDER="$HOME/.config"
cp -R "${source_dir}/$TARGET_FOLDER" $DESTINATION_FOLDER
# Target folder to be copied
TARGET_FOLDER="$(dirname "$(realpath "$0")")/awesome/rofi"
# Path of destination folder
DESTINATION_FOLDER="$HOME/.config"
cp -R "${source_dir}/$TARGET_FOLDER" $DESTINATION_FOLDER

echo "######   Installing Theming Packages #######"
sudo pacman -S --noconfirm --needed lxappearance a-candy-beauty-icon-theme-git

echo "######   Coping Theme files  #######"
# Target folder to be copied
TARGET_FOLDER="$(dirname "$(realpath "$0")")/Icon/Breeze-Dark-Fuchsia.tar.gz"
# Path of destination folder
DESTINATION_FOLDER="$HOME/.local/share/icons/Breeze-Dark-Fuchsia.tar.gz"
mkdir $HOME/.local/share/icons
cp -R "${source_dir}/$TARGET_FOLDER" $DESTINATION_FOLDER
TARGET_FOLDER="$(dirname "$(realpath "$0")")/Icon/Sweet-Dark-v40.zip"
DESTINATION_FOLDER="$HOME/.themes/Sweet-Dark-v40.zip"
mkdir $HOME/.themes
cp -R "${source_dir}/$TARGET_FOLDER" $DESTINATION_FOLDER
TARGET_FOLDER="$(dirname "$(realpath "$0")")/Icon/settings.ini"
DESTINATION_FOLDER="$HOME/.config/gtk-3.0/settings.ini"
mkdir $HOME/.config/gtk-3.0
cp -R "${source_dir}/$TARGET_FOLDER" $DESTINATION_FOLDER
TARGET_FOLDER="$(dirname "$(realpath "$0")")/Icon/index.theme"
DESTINATION_FOLDER="$HOME/.icons/default/index.theme"
mkdir $HOME/.icons/default
cp -R "${source_dir}/$TARGET_FOLDER" $DESTINATION_FOLDER
sudo cp "${source_dir}/$TARGET_FOLDER"  /usr/share/icons/default/index.theme
echo "Completed!!"

echo "######   Appling Cursor  #######"
cd /$HOME/.local/share/icons
tar xvf Breeze-Dark-Fuchsia.tar.gz
cd /$HOME/.config/gtk-3.0
KNOWN_SENTENCE="gtk-cursor-theme-name="
NEW_STRING="Breeze_Dark_Fuchsia"
FILE_NAME="settings.ini"
# Temporary file
TMP_FILE=$(mktemp)
# Replacement logic
sed "s/\(${KNOWN_SENTENCE}\).*$/\1 ${NEW_STRING}/" "$FILE_NAME" > "$TMP_FILE" && mv "$TMP_FILE" "$FILE_NAME"
#sudo rm "$TMP_FILE"
echo "Complete!!"

echo "######   Appling Icon  #######"
cd /$HOME/.config/gtk-3.0
KNOWN_SENTENCE="gtk-icon-theme-name="
NEW_STRING="a-candy-beauty-icon-theme"
FILE_NAME="settings.ini"
# Temporary file
TMP_FILE=$(mktemp)
# Replacement logic
sed "s/\(${KNOWN_SENTENCE}\).*$/\1 ${NEW_STRING}/" "$FILE_NAME" > "$TMP_FILE" && mv "$TMP_FILE" "$FILE_NAME"
#sudo rm "$TMP_FILE"
echo "Complete!!"

echo "######   Appling Sweet Dark Theme  #######"
cd /$HOME/.themes
unzip Sweet-Dark-v40.zip
cd /$HOME/.config/gtk-3.0
KNOWN_SENTENCE="gtk-theme-name="
NEW_STRING="Sweet-Dark-v40"
FILE_NAME="settings.ini"
# Temporary file
TMP_FILE=$(mktemp)
# Replacement logic
sed "s/\(${KNOWN_SENTENCE}\).*$/\1 ${NEW_STRING}/" "$FILE_NAME" > "$TMP_FILE" && mv "$TMP_FILE" "$FILE_NAME"
echo "Complete!!"

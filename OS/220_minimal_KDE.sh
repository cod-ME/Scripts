#! /bin/bash
echo
tput setaf 2
echo "##############################################"
echo "##############   Install Minimal KDE   ###############"
echo "##############################################"
tput sgr0
echo
sudo pacman -S --noconfirm xorg-xlsclients glfw-wayland plasma-wayland-session sddm-kcm bluedevil plasma-pa kde-gtk-config kdeplasma-addons kinfocenter kscreen plasma-desktop plasma-systemmonitor plasma-workspace-wallpapers kdialog plasma-firewall ufw plasma-nm arcolinux-sddm-sugar-candy-git
sudo pacman -S --noconfirm --needed kate xfce4-terminal nemo nemo-audio-tab nemo-emblems nemo-fileroller nemo-image-converter nemo-pastebin nemo-preview nemo-python nemo-seahorse nemo-share nemo-terminal nemo-theme-glacier

echo
tput setaf 2
echo "##############################################"
echo "####################  DONE   ####################"
echo "##############################################"
tput sgr0
echo

echo "######   Appling sddm settings #######"

sudo systemctl enable sddm
sudo systemctl enable NetworkManager

# Specify the target file
target_file="/usr/lib/sddm/sddm.conf.d/default.conf"
# Create a temporary file
temp_file=$(mktemp)
# Define the sentence you want to find
search_sentence="[Theme]
# Current theme name
Current="
# Define the word you want to add after the sentence
word_to_add="arcolinux-sugar-candy"
# Use sed to add the word after the sentence in the target file
awk -v RS='' -v ORS='\n\n' -v sentence="$search_sentence" -v word="$word_to_add" '{
    if ($0 == sentence) {
        sub("\n$", "")
        print $0 "" word
    } else {
        print
    }
}' "$target_file" > "$temp_file"

# Replace the original file with the temporary one
sudo mv "$temp_file" "$target_file"
# Clean up the temporary file
rm -f "$temp_file"

echo "######   DONE   ######"

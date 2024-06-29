#! /bin/bash

echo
tput setaf 2
echo "##############################################"
echo "################   Install Hyprland   ################"
echo "##############################################"
tput sgr0
echo

echo "################   Installing Dependencies   ################"
Dependencies="gdb gcc cmake libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libx11 libxcomposite xorg-xinput libxrender pixman wayland-protocols cairo pango seatd libxkbcommon xcb-util-wm xorg-xwayland libinput libliftoff libdisplay-info cpio tomlplusplus"

# Function to check if Pikaur is installed
check_pikaur_installed() {
    if ! command -v pikaur &> /dev/null; then
        echo "Pikaur not installed. Installing Pikaur..."
        install_pikaur
    else
        echo "Pikaur is already installed."
    fi
}

# Function to install Pikaur
install_pikaur() {
    cd ~
    git clone https://aur.archlinux.org/pikaur.git
    cd pikaur
    makepkg -fsri --noconfirm
    cd ..
    rm -rf pikaur
}
# Function to install an AUR package using Pikaur
install_aur_package() {
    pikaur -S --noconfirm $Dependencies
}
sudo pacman -S --noconfirm --needed git base-devel

check_pikaur_installed
#install_aur_package
echo "##########  Installing Hyprland  #############"

sudo pacman -S --noconfirm --needed xorg-xlsclients xdg-desktop-portal-hyprland glfw-wayland qt5-wayland qt6-wayland swaync hyprland hypridle hyprlock xdg-desktop-portal-hyprland aylurs-gtk-shell cliphist eww wlogout aylurs-gtk-shell glm meson ninja swappy grim xclip intel-ucode
sudo pacman -S --noconfirm --needed sddm ufw arcolinux-sddm-sugar-candy-git wofi rofi-wayland waybar polkit network-manager-applet pipewire socat ncdu nvtop pavucontrol kdeconnect
sudo pacman -S --noconfirm --needed cmake make gdb ninja gcc libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libx11 libxcomposite xorg-xinput libxrender pixman wayland-protocols wlroots-git cairo pango hyprwayland-scanner
sudo pacman -S --noconfirm --needed kitty xfce4-terminal nemo nemo-audio-tab nemo-emblems nemo-fileroller nemo-image-converter nemo-pastebin nemo-preview nemo-python nemo-seahorse nemo-share nemo-terminal nemo-theme-glacier btop

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

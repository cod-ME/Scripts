#!/bin/bash

echo "########  Installing AUR packages  #######"

# AUR package to install
AUR_PACKAGE="anytype-bin waterfox-bin thorium-browser-bin"

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
    pikaur -S --noconfirm $AUR_PACKAGE
}

# Main script execution
sudo pacman -S --noconfirm --needed git
check_pikaur_installed
install_aur_package

echo "Installation of $AUR_PACKAGE completed."






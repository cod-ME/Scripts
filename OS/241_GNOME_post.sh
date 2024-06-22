#!/bin/bash

echo "######   Installing GNOME extension  #######"

# AUR package to install
AUR_PACKAGE="gnome-shell-extension-unite gnome-shell-extension-arch-update"

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

echo "########  Installing Additional extensions  ##########"

#theme() {
cd ~
git clone https://github.com/aunetx/blur-my-shell
cd blur-my-shell
make install
#makepkg -fsri --noconfirm
cd ..
rm -rf blur-my-shell

cd ~
git clone https://gitlab.gnome.org/jrahmatzadeh/just-perfection
cd just-perfection
./scripts/build.sh -i
cd ..
rm -rf just-perfection

cd ~
git clone https://github.com/icedman/search-light
cd search-light
make install
#makepkg -fsri --noconfirm
cd ..
rm -rf search-light

cd ~
git clone https://github.com/Favo02/workspaces-by-open-apps
cd workspaces-by-open-apps
#make install
./install.sh
cd ..
rm -rf workspaces-by-open-apps
#}

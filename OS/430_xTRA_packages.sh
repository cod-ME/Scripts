#!/bin/bash

echo "########  Installing xTRA packages  #######"

sudo pacman -S --noconfirm --needed thunderbird spotify-adblock-git spotube freetube keepassxc stacer hypnotix cpupower-gui cups simple-scan zotero-bin
sudo pacman -S --noconfirm --needed chatgpt-desktop-bin gpt4all-chat-git
sudo pacman -S --noconfirm --needed bottles arch-install-scripts
echo "#############  DONE   ###############"

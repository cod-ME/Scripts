#!/bin/bash

echo "########  Installing xTRA packages (libreoffice)  #######"

sudo pacman -S --noconfirm --needed libreoffice-fresh libreoffice-fresh-de libreoffice-fresh-en-gb libreoffice-fresh-am libreoffice-extension-writer2latex libreoffice-extension-texmaths hunspell hunspell-de hunspell-en_gb

echo "#############  DONE   ###############"

#! /bin/bash
echo
tput setaf 2
echo "##############################################"
echo "##############  CORE Packages   ################"
echo "##############################################"
tput sgr0
echo

sudo pacman -S --noconfirm --needed  nemo nemo-audio-tab nemo-emblems nemo-fileroller nemo-image-converter nemo-pastebin nemo-preview nemo-python nemo-seahorse nemo-share nemo-terminal nemo-theme-glacier rofi-calc rofi-emoji rofi-pass
sudo pacman -S --noconfirm --needed xfce4-terminal xfce4-panel-profiles xfce4-clipman-plugin xfce4-cpufreq-plugin xfce4-cpugraph-plugin xfce4-diskperf-plugin xfce4-dockbarx-plugin xfce4-docklike-plugin xfce4-eyes-plugin xfce4-fsguard-plugin xfce4-genmon-plugin xfce4-mailwatch-plugin xfce4-mount-plugin xfce4-mpc-plugin xfce4-netload-plugin xfce4-notes-plugin xfce4-pulseaudio-plugin xfce4-sensors-plugin xfce4-smartbookmark-plugin xfce4-time-out-plugin xfce4-timer-plugin xfce4-verve-plugin xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-windowck-plugin-xfwm4-theme-support xfce4-xkb-plugin xfce4-systemload-plugin xfce4-cpugraph-plugin
sudo pacman -S --noconfirm --needed sublime-text-4 kitty firefox feh

tput setaf 2
echo "##############################################"
echo "##################  DONE   #####################"
echo "##############################################"
tput sgr0
echo

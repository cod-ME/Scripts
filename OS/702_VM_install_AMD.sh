#!/bin/bash

echo
tput setaf 2
echo "####################################################"
echo "#############   Install VirtManager   ##############"
echo "####################################################"
tput sgr0
echo

sudo pacman -S --noconfirm --needed archlinux-keyring qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat dmidecode ebtables iptables libguestfs

echo "##########   Enabling libvirt Service  ###########"
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service
systemctl status libvirtd.service

echo "##########   Enabling user account to use KVM  ###########"
# Specify the target file
target_file="/etc/libvirt/libvirtd.conf"
### Part 1 of the edit ###
# Define the sentence you want to find and the new string
KNOWN_SENTENCE="# unix_sock_rw_perms = \"0770\""
NEW_STRING="unix_sock_rw_perms = \"0770\""
# Create a temporary file
temp_file=$(mktemp)
# Use sed to replace the line with the known sentence with the new string
sed "s/^${KNOWN_SENTENCE}.*/${NEW_STRING}/" "$target_file" > "$temp_file" && sudo mv "$temp_file" "$target_file"
### Part 2 of the edit ###
KNOWN_SENTENCE="# unix_sock_group = \"libvirt\""
NEW_STRING="unix_sock_group = \"libvirt\""
# Create a temporary file
temp_file=$(mktemp)
# Use sed to replace the line with the known sentence with the new string
sed "s/^${KNOWN_SENTENCE}.*/${NEW_STRING}/" "$target_file" > "$temp_file" && sudo mv "$temp_file" "$target_file"

sudo usermod -a -G libvirt $(whoami)
newgrp libvirt
sudo systemctl restart libvirtd.service

echo "##########   Enabling Nested Virtualization  ###########"
### Intel Processor ###
# sudo modprobe -r kvm_intel
# sudo modprobe kvm_intel nested=1
# echo "options kvm-intel nested=1" | sudo tee /etc/modprobe.d/kvm-intel.conf
# systool -m kvm_intel -v | grep nested
### AMD Processor ###
sudo modprobe -r kvm_amd
sudo modprobe kvm_amd nested=1
echo "options kvm_amd nested=1" | sudo tee /etc/modprobe.d/kvm-amd.conf
systool -m kvm_amd -v | grep nested


echo
tput setaf 2
echo "##############################################"
echo "##################  DONE   ###################"
echo "##############################################"
tput sgr0
echo

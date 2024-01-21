#!/bin/bash

echo "************** Currently chrooted into your future system ***********"
echo ""
echo ""
echo "############### Post installations system configurations #############"
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc
locale-gen
echo "LANG=en_GB.UTF-8" > /etc/locale.conf
echo "KEYMAP=de" > /etc/vconsole.conf
echo SCHERZiNGER > /etc/hostname
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1	localhost" >> /etc/hosts
echo "127.0.1.1	SCHERZiNGER" >> /etc/hosts
echo "++++++++++++ Input root password below ++++++++++"
passwd
echo "+++++++++++++ Adding your user below ++++++++++++"
useradd -m -g users -G wheel -s /bin/zsh splin
echo "+++++++++++++ Passowrd for your user ++++++++++++"
passwd splin
echo "+++++++++++ Adding your user to suoder ++++++++++"
# Specify the target file
target_file="/etc/sudoers"
### Part 1 of the edit ###
# Define the sentence you want to find and the new string
KNOWN_SENTENCE="# %wheel ALL=(ALL:ALL) ALL"
NEW_STRING="%wheel ALL=(ALL:ALL) ALL"
# Create a temporary file
temp_file=$(mktemp)
# Use sed to replace the line with the known sentence with the new string
sed "s/^${KNOWN_SENTENCE}.*/${NEW_STRING}/" "$target_file" > "$temp_file" && mv "$temp_file" "$target_file"

pacman --noconfirm -S networkmanager grub efibootmgr os-prober sudo
systemctl enable NetworkManager
echo "########## Installing GRUB ############"
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi --removable
grub-mkconfig -o /boot/grub/grub.cfg
echo "########## Installation complete #######"
echo "++++++++++ remember to reboot ++++++++"
exit


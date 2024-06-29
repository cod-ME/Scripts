#!/bin/bash
loadkeys de
echo
tput setaf 2
echo "############## Mounting of drive ##############"
tput sgr0
echo
# List available disks
echo "Listing available disks:"
fdisk --list
# Ask the user to specify the disk to mount
tput setaf 2
read -p "Enter the disk you want to mount as /mnt: " disk
tput sgr0
# Construct the full device path
device="/dev/${disk}"

# Check if the device file exists
if [ ! -b "$device" ]; then
    echo "The specified disk does not exist: $device"
    exit 1
fi

# Ask if the user wants to format the disk
read -p "Do you want to format $device to Btrfs? This will erase all data on the disk. (y/n): " format_choice
if [[ "$format_choice" == "y" || "$format_choice" == "Y" ]]; then
    echo "Formatting $device to Btrfs..."
    mkfs.btrfs -f "$device"
    if [ $? -ne 0 ]; then
        echo "Failed to format the disk."
        exit 1
    fi
    echo "Format complete."
fi

# Mount the disk to /mnt
echo "Mounting $device to /mnt..."
mount "$device" /mnt

# Check if the mount was successful
if [ $? -eq 0 ]; then
    echo "Mounted $device successfully to /mnt."
else
    echo "Failed to mount $device."
fi

mkdir -p /mnt/home
tput setaf 2
read -p "Enter the disk you want to mount as /mnt/home;" disk
tput sgr0
device="/dev/${disk}"
if [ ! -b "$device"]; then
	echo "The specified disk does not exist; $device"
	exit 1
fi
echo "Mounting $device to /mnt/home..."
mount "$device" /mnt/home
if [ $? -eq 0 ]; then
	echo "Mounted $device successfully to /mnt/home."
else
	echo "Failed to mount $device."
fi

mkdir -p /mnt/boot/efi
tput setaf 2
read -p "Enter the disk you want to mount as /mnt/boot/efi: " disk
tput sgr0
# Construct the full device path
device="/dev/${disk}"

# Check if the device file exists
if [ ! -b "$device" ]; then
    echo "The specified disk does not exist: $device"
    exit 1
fi

# Ask if the user wants to format the disk
read -p "Do you want to format $device to fat32? This will erase all data on the disk. (y/n): " format_choice
if [[ "$format_choice" == "y" || "$format_choice" == "Y" ]]; then
    echo "Formatting $device to Btrfs..."
    mkfs.fat -F 32 "$device"
    if [ $? -ne 0 ]; then
        echo "Failed to format the disk."
        exit 1
    fi
    echo "Format complete."
fi

# Mount the disk to /mnt/boot/efi
echo "Mounting $device to /mnt/boot/efi..."
mount "$device" /mnt/boot/efi

# Check if the mount was successful
if [ $? -eq 0 ]; then
    echo "Mounted $device successfully to /mnt/boot/efi."
else
    echo "Failed to mount $device."
fi

echo "############## Base ARCH installaion ##############"
sudo pacstrap /mnt base linux-firmware linux btrfs-progs intel-ucode neovim zsh

echo "############## Generating fstab ###############"
genfstab -U -p /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab
echo "++++++++++++++ I hope you see 3 partitions ++++++++++"
echo "++++++++ If you havn't seen the 3 partitions, create a root, boot(efi), and home partitions +++++++++"
echo "++++++++ Then mount them to your partitions as /mnt, /mnt/boot/efi, and /mnt/home respectively ++++++"
tput setaf 2
echo "************** Currently chrooted into your future system ***********"
tput sgr0
arch-chroot /mnt /bin/bash
echo ""
echo ""
echo "############### continue to part 2 of the script (010_Sys_configuration.sh) #############"


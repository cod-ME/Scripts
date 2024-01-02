#!/bin/bash
echo "############## Base ARCH installaion ##############"
pacstrap /mnt base linux-firmware linux btrfs-progs intel-ucode neovim zsh

echo "############## Generating fstab ###############"
genfstab -U -p /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab
echo "++++++++++++++ I hope you see 3 partitions ++++++++++"
echo "++++++++ If you havn't seen the 3 partitions, create a root, boot(efi), and home partitions +++++++++"
echo "++++++++ Then mount them to your partitions as /mnt, /mnt/boot/efi, and /mnt/home respectively ++++++"
arch-chroot /mnt /bin/bash
echo "************** Currently chrooted into your future system ***********"
echo ""
echo ""
echo "############### continue to part 2 of the script (010_Sys_configuration.sh) #############"


#!/bin/bash
echo "############## Base ARCH installaion ##############"
pacstrap /mnt base base-devel linux-firmware linux btrfs-progs intel-ucode neovim

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
echo "++++++++++ Input root password below +++++++++"
passwd
pacman --noconfirm -S networkmanager grub efibootmgr
systemctl enable NetworkManager
echo "########## Installing GRUB ############"
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi --removable
grub-mkconfig -o /boot/grub/grub.cfg
echo "########## Installation complete #######"
echo "++++++++++ remember to exit chroot ++++++++"

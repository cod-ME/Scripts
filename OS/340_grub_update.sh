sudo grub-mkconfig -o /boot/grub/grub.cfg

sudo timedatectl set-local-rtc 1
sudo hwclock --systohc --localtime

sudo pacman -S --noconfirm --needed intel-ucode libwacom-surface linux-firmware

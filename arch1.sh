#!/bin/bash

# Ставим русскую раскладку
loadkeys ru

# Добавим в консоль шрифт, поддерживающий кириллицу
setfont cyr-sun16

#Добавляем русскую локаль
sed -i 's/#ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
export LANG=ru_RU.UTF-8

# Partitioning
#
# 1 - /boot
# 2 - /
# 3 - swap 
# 4 - /home

parted /dev/sda mklabel gpt
parted -a optimal /dev/sda mkpart fat32 2048s 1024.0
parted /dev/sda name 1 Boot 
parted -a optimal /dev/sda mkpart ext2 1024.0 20G
parted /dev/sda name 2 Root
parted /dev/sda set 1 boot on
parted /dev/sda set 1 esp on

mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2 -L root

mount /dev/sda2 /mnt
mkdir /mnt/{boot,home}
mount /dev/sda1 /mnt/boot
# mount /dev/sda4 /mnt/home
# swapon /dev/sda3

# Выбираем ближайшее зеркало для pacman
sed -i '1 i\Server = http://mirror.yandex.ru/archlinux/$repo/os/$arch' /etc/pacman.d/mirrorlist
 
# Установим базовые пакеты системы.
pacstrap -i /mnt base base-devel
# Для тех, кто устанавливает систему через Wi-Fi необходимо также установить пакеты netctl, dialog и wpa_supplicant
pacstrap -i /mnt netctl dialog wpa_supplicant wget
# Установка загрузчика Grub
#Для BIOS:
# arch-chroot /mnt pacman -S grub-bios
#Для EFI:
#arch-chroot /mnt pacman -S grub-efi-x86_64

# Дальнейшая настройка системы

# Генерируем fstab, используя следующую команду:

genfstab -p /mnt >> /mnt/etc/fstab

echo "Переход в CHROOT. Запусти arch2.sh"

#Переходим в свежеустановленную систему:
arch-chroot /mnt /bin/bash

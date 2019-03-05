#!/bin/bash

#Добавляем русскую локаль
sed -i 's/#ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/g' /etc/locale.gen
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen

#Добавим русскую локаль в консоль
#sed -i 's/HOOKS=(base /HOOKS=(base keymap /g' /etc/mkinitcpio.conf
# Видеокарта Intel 
#sed -i 's/MODULES=() /MODULES=(i915)/g' /etc/mkinitcpio.conf
# Видеокарта Nvidia
#sed -i 's/MODULES=() /MODULES=(nouveau)/g' /etc/mkinitcpio.conf
echo "Открываем файл mkinitcpio.conf (# nano /etc/mkinitcpio.conf) и прописываем хук keymap в разделе HOOKS. В разделе MODULES прописываем драйвер видеокарты:"
echo "Для Nvidia – nouveau, Для Intel – i915, Для AMD – radeon"
sleep 10
nano /etc/mkinitcpio.conf
mkinitcpio -p linux
#grub-install /dev/sda
#grub-mkconfig -o /boot/grub/grub.cfg
# Install and configure a bootloader
bootctl install
curl http://vds.victor3d.com.br/boot/loader/entries/arch.conf > /boot/loader/entries/arch.conf

echo "Установка пароля для ROOT"
passwd
wget http://vds.victor3d.com.br/arch3.sh
chmod +x arch3.sh
echo "Сделай exit и reboot и запусти arch3.sh"
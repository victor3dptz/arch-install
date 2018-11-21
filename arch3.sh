#!/bin/bash

#Настраиваем сеть

systemctl enable dhcpcd
systemctl start dhcpcd

# Меняем имя компьютера (myhostname меняем на ваше):
hostnamectl set-hostname ThinkCentre

# Настраиваем временную зону:
timedatectl set-timezone Europe/Moscow

timedatectl set-ntp true
hwclock --systohc --utc

# Русифицируем нашу систему:

localectl set-keymap ru
setfont cyr-sun16
localectl set-locale LANG="ru_RU.UTF-8"
export LANG=ru_RU.UTF-8

echo "FONT=cyr-sun16" >> /etc/vconsole.conf

echo "" >> /etc/pacman.conf
echo "[archlinuxfr]" >> /etc/pacman.conf
echo "SigLevel = Never" >> /etc/pacman.conf
echo "Server = http://repo.archlinux.fr/x86_64" >> /etc/pacman.conf

echo "pacman: раскомментируй multilib"
sleep 10
nano /etc/pacman.conf
pacman -Suy
pacman -S --needed base-devel git wget yajl

# Добавим своего пользователя (меняем username на свое) и добавляем его в нужные группы:
useradd -m -g users -G audio,games,lp,optical,power,scanner,storage,video,wheel -s /bin/bash victor3d
# Установим пароль для нашего юзера:
passwd victor3d
#Добавим ему информацию GECOS:
chfn victor3d

# Устанавливаем и настраиваем sudo
pacman -S sudo

echo "В файле /etc/sudoers снимаем комментарий со строки # %wheel ALL=(ALL) ALL"
sleep 10
EDITOR=nano visudo

pacman -S xorg-server xorg-xinit mesa-libgl xterm mesa

# Parallels Desktop Testing
pacman -S xf86-video-vesa

# Intel 
#pacman -S xf86-video-intel lib32-intel-dri

pacman -S tint2 feh acpi mc nano cdparanoia cdrkit p7zip unrar zip openssh openbox obconf obmenu openbox-themes faenza-icon-theme tangerine-icon-theme pcmanfm file-roller gvfs gnome-menus ntfs-3g dosfstools exfat-utils xbindkeys networkmanager network-manager-applet hicolor-icon-theme gpicview volumeicon

curl http://vds.victor3d.com.br/etc/X11/xorg.conf.d/20-keyboard-layout.conf > /etc/X11/xorg.conf.d/20-keyboard-layout.conf

# LightDM
pacman -S lightdm lightdm-gtk-greeter
systemctl enable lightdm
curl http://vds.victor3d.com.br/etc/lightdm/lightdm-gtk-greeter.conf > /etc/lightdm/lightdm-gtk-greeter.conf

mkdir -p /usr/share/images
curl http://vds.victor3d.com.br/usr/share/images/flowery.jpg > /usr/share/images/flowery.jpg
curl http://vds.victor3d.com.br/usr/share/images/linen.png > /usr/share/images/linen.png

curl http://vds.victor3d.com.br/usr/local/bin/i3lock.sh > /usr/local/bin/i3lock.sh
curl http://vds.victor3d.com.br/usr/local/bin/mutt.sh > /usr/local/bin/mutt.sh
curl http://vds.victor3d.com.br/usr/local/bin/passmenu > /usr/local/bin/passmenu
curl http://vds.victor3d.com.br/usr/local/bin/ssh_menu.sh > /usr/local/bin/ssh_menu.sh
curl http://vds.victor3d.com.br/usr/local/bin/top50vote > /usr/local/bin/top50vote
curl http://vds.victor3d.com.br/usr/local/bin/weather.py > /usr/local/bin/weather.py
chmod +x /usr/local/bin/*

pacman -S xcompmgr conky lxappearance geany ttf-liberation ttf-dejavu opendesktop-fonts ttf-bitstream-vera ttf-arphic-ukai ttf-arphic-uming ttf-hanazono
#pacman -S xfce4-power-manager
pacman -S lxterminal transmission-gtk filezilla libva-intel-driver i3lock scrot imagemagick xautolock mcabber mpv htop dmenu xfce4-screenshooter pulseaudio pulseaudio-alsa procmail fetchmail poppler lynx mutt terminator alsa-utils moc gmrun


echo "Все установлено!! Зайди в юзера и скачай arch4.sh"

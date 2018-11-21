#!/bin/bash

curl http://vds.victor3d.com.br/home/dotbashrc > ~/.bashrc
curl http://vds.victor3d.com.br/home/dotconkyrc > ~/.conkyrc
curl http://vds.victor3d.com.br/home/dotfonts.conf > ~/.fonts.conf
curl http://vds.victor3d.com.br/home/dotgtkrc-2.0 > ~/.gtkrc-2.0
mkdir ~/.moc
curl http://vds.victor3d.com.br/home/dotmoc/config > ~/.moc/config
mkdir -p ~/.config/openbox
curl http://vds.victor3d.com.br/home/dotconfig/openbox/autostart > ~/.config/openbox/autostart
curl http://vds.victor3d.com.br/home/dotconfig/openbox/environment > ~/.config/openbox/environment
curl http://vds.victor3d.com.br/home/dotconfig/openbox/menu.xml > ~/.config/openbox/menu.xml
curl http://vds.victor3d.com.br/home/dotconfig/openbox/rc.xml > ~/.config/openbox/rc.xml
mkdir ~/.config/menus
curl http://vds.victor3d.com.br/home/dotconfig/menus/applications.menu > ~/.config/menus/applications.menu
mkdir ~/.config/dmenu
curl http://vds.victor3d.com.br/home/dotconfig/dmenu/dmenu-bind.sh > ~/.config/dmenu/dmenu-bind.sh
chmod +x ~/.config/dmenu/dmenu-bind.sh
mkdir ~/.config/tint2
curl http://vds.victor3d.com.br/home/dotconfig/tint2/tint2rc > ~/.config/tint2/tint2rc

# AUR
git clone https://aur.archlinux.org/package-query.git
cd package-query/
makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt/
makepkg -si
cd ..
sudo rm -dR yaourt/ package-query/

yaourt -S bunsen-themes-git
#yaourt -S links-g-directfb

gpg --keyserver=keyserver.ubuntu.com --recv-keys 865E6C87C65285EC
yaourt -S palemoon-bin palemoon-i18n-ru

echo "All done! Перегрузись !"
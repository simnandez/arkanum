#!/bin/bash

# 1. Eliminar Plymouth y rastro de splash
apt-get purge -y plymouth plymouth-themes
apt-get autoremove -y
# Limpiamos el rastro en el archivo de grub para que no busque el splash
if [ -f /etc/default/grub ]; then
    sed -i 's/quiet splash/quiet/g' /etc/default/grub
fi

# 2. Eliminar el icono de Penguin Eggs del escritorio Live
# Buscamos en skel (lo que heredará el usuario live) y en applications
rm -f /etc/skel/Desktop/penguineggs.desktop
rm -f /usr/share/applications/penguineggs.desktop
rm -f /usr/share/applications/eggs.desktop

#3 Visual Studio Code
mkdir -p /etc/skel/.config/Code/User/
cat <<EOF > /etc/skel/.config/Code/User/settings.json
{
    "window.titleBarStyle": "native"
}
EOF

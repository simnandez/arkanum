# =================================================================
# Script de preparación para Respin Debian ArKanum
# Objetivo: Configurar Dolphin (KDE) y VS Code en /etc/skel
# =================================================================

# Salir si hay errores
set -e

echo "--- Iniciando preparación del entorno skel ---"

# 1. Preparación inicial de Penguin Eggs
sudo eggs tools skel

# 2. Configuración de Dolphin (KDE)
echo "Configurando Dolphin..."
sudo mkdir -p /etc/skel/.config /etc/skel/.local/share/dolphin /etc/skel/.local/share/kxmlgui5/dolphin

# Copiar archivos de configuración
sudo cp ~/.config/dolphinrc /etc/skel/.config/
sudo cp ~/.local/share/user-places.xbel /etc/skel/.local/share/
sudo cp -r ~/.local/share/dolphin/view_properties /etc/skel/.local/share/dolphin/
sudo cp ~/.local/share/kxmlgui5/dolphin/dolphinui.rc /etc/skel/.local/share/kxmlgui5/dolphin/

# LIMPIEZA CRÍTICA: Eliminar rutas absolutas del usuario actual
sudo sed -i "s|/home/$USER|/home/usuario|g" /etc/skel/.config/dolphinrc
sudo sed -i "/\/home\/$USER/d" /etc/skel/.config/dolphinrc
sudo sed -i "s|/home/$USER|/home/usuario|g" /etc/skel/.local/share/user-places.xbel

# 3. Configuración de VS Code (Python & PHP)
echo "Configurando Visual Studio Code..."
sudo mkdir -p /etc/skel/.config/Code/User
sudo mkdir -p /etc/skel/.vscode/extensions

# Copiar configuración y extensiones
# Usamos . en el origen para asegurar que no cree una carpeta 'User' dentro de 'User'
sudo cp -r ~/.config/Code/User/. /etc/skel/.config/Code/User/
sudo cp -r ~/.vscode/extensions/. /etc/skel/.vscode/extensions/

# Limpieza de temporales de VS Code para reducir tamaño de la ISO
echo "Limpiando archivos temporales de VS Code..."
sudo rm -rf /etc/skel/.config/Code/User/workspaceStorage/*
sudo rm -rf /etc/skel/.config/Code/User/globalStorage/*
sudo rm -rf /etc/skel/.config/Code/User/CachedData/*
sudo rm -rf /etc/skel/.config/Code/User/logs/*
sudo rm -f /etc/skel/.config/Code/User/storage.json

# 4. Ajuste final de permisos en el skel
echo "Ajustando permisos..."
sudo chown -R root:root /etc/skel
sudo chmod -R 755 /etc/skel

# 5. Generación de la ISO
echo "--- Iniciando producción de la ISO ---"
# --release para que sea instalable, --theme para la estética
sudo eggs produce --release --noicon --theme=.wardrobe/vendors/debian-arkanum

echo "--- Proceso finalizado con éxito ---"

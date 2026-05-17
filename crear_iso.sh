# =================================================================
# Script de preparación para Respin Debian ArKanum
# Objetivo: Configurar Dolphin (KDE) y VS Code en /etc/skel
# =================================================================

# Salir si hay errores
set -e

echo "--- Iniciando preparación del entorno skel ---"

# Detectar el usuario real que lanza el script antes de usar sudo
REAL_USER=${SUDO_USER:-$USER}
REAL_HOME=$(eval echo ~$REAL_USER)

# 1. Preparación inicial de Penguin Eggs
sudo eggs tools skel

# 2. Configuración de Dolphin (KDE)
echo "Configurando Dolphin..."
sudo mkdir -p /etc/skel/.config /etc/skel/.local/share/dolphin /etc/skel/.local/share/kxmlgui5/dolphin

# Copiar archivos de configuración utilizando las rutas reales del usuario
sudo cp "$REAL_HOME/.config/dolphinrc" /etc/skel/.config/
sudo cp "$REAL_HOME/.local/share/user-places.xbel" /etc/skel/.local/share/
sudo cp -r "$REAL_HOME/.local/share/dolphin/view_properties" /etc/skel/.local/share/dolphin/
sudo cp "$REAL_HOME/.local/share/kxmlgui5/dolphin/dolphinui.rc" /etc/skel/.local/share/kxmlgui5/dolphin/

# LIMPIEZA CRÍTICA: Adaptación para el entorno del Respin
echo "Aplicando limpieza crítica de rutas en el skel..."

# En dolphinrc cambiamos las rutas fijas por una genérica o las limpiamos
sudo sed -i "s|$REAL_HOME|/home/usuario|g" /etc/skel/.config/dolphinrc
sudo sed -i "s|file://$REAL_HOME|file:///home/usuario|g" /etc/skel/.config/dolphinrc

# En user-places.xbel eliminamos los bloques personalizados para que KDE los regenere limpios
if [ -f /etc/skel/.local/share/user-places.xbel ]; then
    sudo sed -i "/<bookmark/ , /<\/bookmark>/{/home\/${REAL_USER}/d}" /etc/skel/.local/share/user-places.xbel
fi


# 3. Configuración de VS Code (Python & PHP)
echo "Configurando Visual Studio Code..."
sudo mkdir -p /etc/skel/.config/Code/User
sudo mkdir -p /etc/skel/.vscode/extensions

# Copiar configuración y extensiones utilizando las rutas reales
sudo cp -r "$REAL_HOME/.config/Code/User/." /etc/skel/.config/Code/User/
sudo cp -r "$REAL_HOME/.vscode/extensions/." /etc/skel/.vscode/extensions/

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
echo "--- Limpiando residuos de compilaciones anteriores ---"
sudo eggs tools clean

echo "--- Iniciando producción de la ISO ---"

# Preguntar al usuario si desea renovar el yolk
echo ""
read -p "¿Deseas renovar el yolk en esta compilación? (s/N): " respuesta

# Convertir la respuesta a minúsculas para evitar problemas
respuesta=$(echo "$respuesta" | tr '[:upper:]' '[:lower:]')

if [ "$respuesta" = "s" ] || [ "$respuesta" = "si" ]; then
    echo "Generando ISO incluyendo la renovación del yolk..."
    sudo eggs produce --release --noicon --yolk --theme=.wardrobe/vendors/debian-arkanum
else
    echo "Generando ISO sin renovar yolk..."
    sudo eggs produce --release --noicon --theme=.wardrobe/vendors/debian-arkanum
fi

echo "--- Proceso finalizado con éxito ---"
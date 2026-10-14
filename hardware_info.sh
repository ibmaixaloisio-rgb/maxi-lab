#!/usr/bin/env bash
# hardware_info.sh - Muestra información del hardware en Linux
# Uso: ./hardware_info.sh

echo "==============================================="
echo "        INFORMACIÓN DEL HARDWARE (Linux)       "
echo "==============================================="

echo -e "\n--- Sistema Operativo / Kernel ---"
uname -a
[ -f /etc/os-release ] && cat /etc/os-release | head -2

echo -e "\n--- CPU / Procesador ---"
lscpu 2>/dev/null || grep -E "model name|cpu cores" /proc/cpuinfo | sort -u

echo -e "\n--- Memoria RAM ---"
free -h

echo -e "\n--- Placa Base / BIOS ---"
sudo dmidecode -t bios -t system 2>/dev/null || echo "(requiere sudo y paquete dmidecode)"

echo -e "\n--- Tarjeta Gráfica (GPU) ---"
lspci 2>/dev/null | grep -iE "vga|3d|display" || echo "lspci no disponible"

echo -e "\n--- Almacenamiento (Discos) ---"
lsblk 2>/dev/null
df -hT | grep -vE "tmpfs|udev"

echo -e "\n--- Interfaces de Red ---"
ip -br link 2>/dev/null || ifconfig -a 2>/dev/null

echo -e "\n--- Dispositivos USB ---"
lsusb 2>/dev/null | head -10

echo -e "\n--- Información adicional con inxi (si está instalado) ---"
inxi -Fxz 2>/dev/null || echo "Instalar con: sudo apt install inxi (Debian/Ubuntu) o sudo dnf install inxi (Fedora)"

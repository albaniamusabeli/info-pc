#!/bin/bash

# Obtener el nombre del host y el nombre del usuario
hostname=$(hostname)
username=$(whoami)

# Archivo de salida
output_file="INFO_${hostname}_${username}.txt"

# Recoger MARCA, MODELO y S/N
echo "" > "$output_file"
echo "Marca: $(sudo dmidecode -s system-manufacturer)" >> "$output_file"
echo "Modelo: $(sudo dmidecode -s system-product-name)" >> "$output_file"
echo "S/N: $(sudo dmidecode -s system-serial-number)" >> "$output_file"

# Recoger la configuración de red
echo "" >> "$output_file"
echo "IPConfig /all:" >> "$output_file"
ip a >> "$output_file"

# Recoger la versión de Ubuntu
echo "" >> "$output_file"
echo "Versión de Ubuntu:" >> "$output_file"
lsb_release -d | cut -f2 >> "$output_file"
uname -r >> "$output_file"

# Recoger la información del CPU (eliminando duplicaciones)
echo "" >> "$output_file"
echo "CPU:" >> "$output_file"
lscpu | grep "Model name" | awk -F ':' '{print $2}' | sed 's/^[ \t]*//' >> "$output_file"

# Recoger la cantidad de RAM
echo "" >> "$output_file"
echo "RAM:" >> "$output_file"
grep MemTotal /proc/meminfo | awk '{print $2 " KB"}' >> "$output_file"

# Recoger las unidades de disco y su capacidad, excluyendo los dispositivos loop
echo "" >> "$output_file"
echo "Unidades de Disco Duro:" >> "$output_file"
lsblk -o NAME,SIZE,TYPE | grep -E "disk|part" >> "$output_file"

# Confirmar si existe el archivo repux en la ruta especificada
echo "" >> "$output_file"
if [ -f "/opt/CarbonBlack/repux" ]; then
    echo "CARBON BLACK AV SI ESTÁ INSTALADO" >> "$output_file"
else
    echo "CARBON BLACK AV NO ESTÁ INSTALADO" >> "$output_file"
fi

echo "" >> "$output_file"
echo "Información recolectada correctamente."

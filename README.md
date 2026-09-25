# info_pc.sh

Script en Bash que recopila la información básica de un equipo Linux (Ubuntu) y la guarda en un archivo de texto. Sirve para hacer inventario de equipos o para tener a mano los datos de un PC en tareas de soporte técnico.

## Qué información recopila

| Sección | Datos | Comando usado |
|---|---|---|
| Hardware | Marca, modelo y número de serie | `dmidecode` |
| Red | Interfaces de red y direcciones IP | `ip a` |
| Sistema | Versión de Ubuntu y del kernel | `lsb_release`, `uname -r` |
| CPU | Modelo del procesador | `lscpu` |
| RAM | Memoria total (en KB) | `/proc/meminfo` |
| Discos | Discos y particiones con su tamaño, sin contar los dispositivos loop | `lsblk` |
| Antivirus | Si Carbon Black está instalado | Comprueba si existe `/opt/CarbonBlack/repux` |

## Requisitos

- Ubuntu o una distribución basada en Debian que tenga `lsb_release`.
- Permisos de `sudo`: `dmidecode` los necesita para leer la marca, el modelo y el número de serie.

## Uso

```bash
chmod +x info_pc.sh
./info_pc.sh
```

El script pedirá la contraseña de `sudo`. Cuando termine, mostrará el mensaje:

```
Información recolectada correctamente.
```

## Archivo de salida

Se crea en la carpeta desde donde se ejecuta el script, con este nombre:

```
INFO_<hostname>_<usuario>.txt
```

Si el archivo ya existe, se sobrescribe.

### Ejemplo del contenido

```
Marca: Dell Inc.
Modelo: Latitude 5420
S/N: ABC1234

IPConfig /all:
1: lo: <LOOPBACK,UP,LOWER_UP> ...
2: enp0s31f6: <BROADCAST,MULTICAST,UP,LOWER_UP> ...
    inet 192.168.1.50/24 ...

Versión de Ubuntu:
Ubuntu 22.04.4 LTS
6.5.0-35-generic

CPU:
11th Gen Intel(R) Core(TM) i5-1145G7 @ 2.60GHz

RAM:
16162340 KB

Unidades de Disco Duro:
nvme0n1     476.9G disk
├─nvme0n1p1   512M part
└─nvme0n1p2 476.4G part

CARBON BLACK AV SI ESTÁ INSTALADO
```

## Notas

- El encabezado de red dice "IPConfig /all" por costumbre de Windows, pero el comando que se ejecuta es `ip a`, que es su equivalente en Linux.
- La RAM aparece en KB. Para pasarla a GB, divide entre 1 048 576 (por ejemplo, 16162340 KB ≈ 15,4 GB).

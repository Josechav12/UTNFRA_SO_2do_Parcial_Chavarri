#!/bin/bash

cat << "FIN" > /tmp/ChavarriAltaUser-Groups.sh

USUARIO_REF=$1
LISTA=$2

# Obtener la contraseña del usuario de referencia
CONTRA=$(sudo grep "$USUARIO_REF" /etc/shadow | awk -F ':' '{print $2}')

# Cambiar el separador de campo para procesar líneas
ANT_IFS=$IFS
IFS=$'\n'

# Procesar el archivo de lista de usuarios
for i in $(cat "$LISTA" | awk -F ',' '{print $1 " " $2 " " $3}' | grep -v '^#'); do
    USUARIO=$(echo "$i" | awk '{print $1}')
    GRUPO=$(echo "$i" | awk '{print $2}')
    HOME_USR=$(echo "$i" | awk '{print $3}')

    # Crear grupo si no existe
    sudo groupadd -f "$GRUPO"
    
    # Crear usuario con directorio de inicio y asignarlo al grupo
    sudo useradd -m -d "$HOME_USR" -g "$GRUPO" "$USUARIO"
    
    # Asignar contraseña al usuario (encriptada)
    echo "$USUARIO:$CONTRA" | sudo chpasswd -e
done

# Restaurar el separador de campo
IFS=$ANT_IFS

FIN

# Movemos el script a la ubicación final y asignar permisos
sudo mv /tmp/ChavarriAltaUser-Groups.sh /usr/local/bin/ChavarriAltaUser-Groups.sh
sudo chmod 755 /usr/local/bin/ChavarriAltaUser-Groups.sh

# Ejecución
/usr/local/bin/ChavarriAltaUser-Groups.sh chavarri /home/vagrant/UTNFRA_SO_2do_Parcial_Chavarri/202406/bash_script/Lista_Usuarios.txt


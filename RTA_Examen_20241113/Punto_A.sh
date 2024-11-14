#creamos los discos de 1G y de 2G

#Acceder al disco de 1gb para particionar: 
sudo fdisk /dev/sdd 

#Particionar como indica el ejercicio (5M): 
#add a new partition=
n 
#Default= 
p 
#Default= 
1 
Enter 
#Almacenamiento= 
+5M 
#change a partition type= 
t 
#Linux LVM= 
8e 
#Guardar= 
wq 

#Se convierte la partición a volumen físico: 
sudo pvcreate /dev/sdd1

#Creamos el grupo de volúmenes “VG” (vg_datos): 
sudo vgcreate vg_datos /dev/sdd1

#Acceder al disco de 2gb para particionar:
sudo fdisk /dev/sdc

#Particionar como indica el ejercicio (1.5gb):
add a new partition=
n 
#Default= 
p 
#Default= 
1 
Enter 
#Almacenamiento=
+1.5G 
#change a partition type= 
t
#Linux LVM= 
8e 
#Guardar=
wq 

#Luego volvemos a convertir a volumen fisico: 
sudo pvcreate /dev/sdc1

#Creamos el grupo de volumenes VG: 
sudo vgextend vg_datos /dev/sdc1

#Acceder al disco de 2gb para particionar: 
sudo fdisk /dev/sdc

#Particionar como indica el ejercicio (512mb): 
#add a new partition= 
n
#Default= 
p
#Default= 
Enter 
#Almacenamiento= 
Enter 
#change a partition type= 
t
2
#Linux LVM= 
8e 
#Guardar= 
wq 

#Luego volvemos a convertir a volumen fisico: 
sudo pvcreate /dev/sdc2

#Creamos el grupo de volumenes (VG): 
sudo vgcreate vg_temp /dev/sdc2

#Creamos el volumen logico de lv_docker “LV”: 
sudo lvcreate -L +4M vg_datos -n lv_docker

#Creamos el volumen logico de lv_workareas: 
sudo lvcreate -l +100%FREE vg_datos -n lv_workareas 

#Creamos el volumen logico de lv_swap: 
sudo lvcreate -l +100%FREE vg_temp -n lv_swap

#Formateamos las particiones:
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_docker
sudo mkfs.ext4 /dev/mapper/vg_datos-lv_workareas
sudo mkswap /dev/vg_temp/lv_swap

#Montamos las particiones:
sudo mount /dev/mapper/vg_datos-lv_docker /var/lib/docker
sudo mount /dev/mapper/vg_datos-lv_workareas /work/
sudo swapon /dev/vg_temp/lv_swap


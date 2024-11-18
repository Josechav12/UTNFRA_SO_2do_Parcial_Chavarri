#Trabajamos dentro de la carpeta:
UTNFRA_SO_2do_Parcial_Chavarri/202406/docker/

#Modificamos el archivo con los datos pedidos:
index.html
<div>
  <h1> Sistemas Operativos - UTNFRA </h1></br>
  <h2> 2do Parcial - noviembre 2024 </h2> </br>
  <h3> Jose Chavarri</h3>
  <h3> División: 115</h3>
</div>

#Guardamos:
:wq

#creamos el archivo Dockerfile:
vim Dockerfile

FROM nginx:latest

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

#Guardamos
:wq

#creamos el run.sh:
vim run.sh

#!/bin/bash
sudo docker run -d -p 8080:80 vhhss/2do_parcial:latest
#Le damos permisos:
sudo chmod 755 run.sh

#construimos la imagen:
sudo docker build -t web1-chavarri .

#nos logueamos en docker
sudo docker login -u josechav12

#etiquetamos la imagen:
docker tag web1-chavarri chavarri/web1-chavarri:latest

#hacemos el push a docker:
sudo docker push josechav12/web1-chavarri:latest



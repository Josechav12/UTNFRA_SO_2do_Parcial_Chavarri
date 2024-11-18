history -a
cp $HOME/.bash_history /home/vagrant/UTNFRA_SO_2do_Parcial_Chavarri/.bash_history

cd /home/vagrant/UTNFRA_SO_2do_Parcial_Chavarri
git add .
git commit -m "Agregado contenido del 2do Parcial y .bash_history"
git push origin main

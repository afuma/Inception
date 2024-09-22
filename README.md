cd /home/edesaint/
mkdir data
cd data
mkdir wordpress mariadb

ou

mkdir -p /home/edesaint/data/{wordpress,mariadb}

cd /home/edesaint/Documents/Inception/srcs/requirements/mariadb
sudo docker exec -it [CONTAINER ID] mariadb

---------------------------------------------------

De ce que j'ai compris du projet Inception:
On doit installer et configurer 3 conteneurs (nginx pour le serveur web)
wordpress pour le site web et mariadb pour la base de donne de notre site web

1er possibiliter:
Il faudrait creer un script qui recupere tous les fichiers de logs et les placent dans un meme dossier
ensuite on les filtres (par la commande GREP "error" et ces variantes, "can't" etc..)
on creer un nouveau fichier avec toutes les erreurs et le noms des fichiers associer a chaque erreur
puis on le donne a une IA pour avoir une reponse precise

2eme possibiliter:
il faudrait creer un script qui tests/verfie la bonne configuration du systeme.
on verifie les droits d'acces au fichiers de la base de donne de mariadb par exemple
on verifie que le parefeu est bien desactiver
on verifie que les dossiers et fichiers wordpress et mariadb sont bien creer
on va a l'interieur des conteneurs (nginx, mariadb et wordpress) pour verifier que la configuration globale
est en coherence avec l'arborescence de dossiers/fichiers
    voir lancer les commandes sudo docker ps (recuperer les IDs)
    sudo docker exec -it [CONTAINER ID] bash
    puis lancer les commandes:
        sudo docker logs mariadb
        sudo docker logs wordpress
        sudo docker logs nginx
    lancer des commandes pour verifiers que le docker compose est fonctionnel
        par exemple: sudo docker inspect inception

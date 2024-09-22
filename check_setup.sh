#!/bin/bash

# Couleurs pour une meilleure lisibilité
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"  # No Color

# Fonction pour vérifier l'état d'un conteneur
check_container() {
    local container_name=$1
    if docker ps --filter "name=$container_name" | grep -q "$container_name"; then
        echo -e "${GREEN}Le conteneur $container_name est en cours d'exécution.${NC}"
    else
        echo -e "${RED}Erreur : Le conteneur $container_name n'est pas en cours d'exécution.${NC}"
    fi
}

# Vérifier les droits d'accès aux fichiers MariaDB
check_mariadb_permissions() {
    echo "Vérification des permissions des fichiers MariaDB..."
    docker exec mariadb ls -ld /var/lib/mysql
    docker exec mariadb ls -l /var/lib/mysql
}

# Vérifier l'état des pare-feu (assume UFW pour l'exemple)
check_firewall() {
    if sudo ufw status | grep -q "inactive"; then
        echo -e "${GREEN}Le pare-feu est désactivé.${NC}"
    else
        echo -e "${RED}Attention : Le pare-feu est activé. Désactivez-le pour assurer le bon fonctionnement des conteneurs.${NC}"
    fi
}

# Vérifier la présence des fichiers et dossiers WordPress et MariaDB
check_filesystem() {
    echo "Vérification des fichiers et dossiers dans WordPress et MariaDB..."
    docker exec wordpress ls -l /var/www/html
    docker exec mariadb ls -l /var/lib/mysql
}

# Vérification des logs des conteneurs
check_logs() {
    echo "Vérification des logs des conteneurs..."
    docker logs mariadb
    docker logs wordpress
    docker logs nginx
}

# Vérifier que le docker-compose est fonctionnel
check_docker_compose() {
    echo "Vérification de la configuration du docker-compose..."
    docker-compose ps
    docker-compose config --services
}

# Exécuter toutes les vérifications
echo "=== Vérification de l'installation des conteneurs ==="
check_container "nginx"
check_container "wordpress"
check_container "mariadb"
echo

check_mariadb_permissions
echo

check_firewall
echo

check_filesystem
echo

check_logs
echo

check_docker_compose
echo

echo -e "${GREEN}Vérifications terminées.${NC}"

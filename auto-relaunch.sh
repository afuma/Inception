#!/bin/bash

# Fonction pour arrêter et supprimer tous les conteneurs Docker
stop_and_remove_docker_containers() {
    echo "Arrêt et suppression des conteneurs Docker..."
    docker stop $(docker ps -aq)
    docker system prune -af
}

# Fonction pour vérifier et arrêter les processus utilisant le port 8080
check_and_stop_port_8080() {
    echo "Vérification du port 8080..."
    pids=$(sudo lsof -t -i :8080)
    
    if [ -n "$pids" ]; then
        echo "Processus utilisant le port 8080 détecté. Arrêt en cours..."
        sudo kill $pids
    else
        echo "Aucun processus utilisant le port 8080."
    fi
}

# Fonction principale
main() {
    echo "Nettoyage des ressources Docker..."
    stop_and_remove_docker_containers
    
    echo "Arrêt et suppression des processus utilisant le port 8080..."
    check_and_stop_port_8080
    
    echo "Redémarrage du service Docker..."
    systemctl restart docker
    
    echo "Démarrage du conteneur Nginx..."
    docker run -d -p 8080:80 nginx
}

# Exécution du script
main

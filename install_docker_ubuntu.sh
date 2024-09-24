#!/bin/bash

# Mettre à jour le système
echo "Mise à jour du système..."
sudo apt update && sudo apt upgrade -y

# Installer les prérequis pour Docker
echo "Installation des prérequis..."
sudo apt install -y ca-certificates curl gnupg lsb-release

# Ajouter la clé GPG officielle de Docker
echo "Ajout de la clé GPG de Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Ajouter le dépôt Docker aux sources APT
echo "Ajout du dépôt Docker aux sources APT..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Mettre à jour les paquets avec le nouveau dépôt Docker
echo "Mise à jour des paquets avec le dépôt Docker..."
sudo apt update

# Installer Docker Engine, CLI, et containerd
echo "Installation de Docker Engine, CLI, et containerd..."
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Vérifier le statut de Docker
echo "Vérification du statut de Docker..."
sudo systemctl status docker --no-pager

# Tester l'installation en exécutant l'image hello-world
echo "Exécution du test avec l'image hello-world..."
sudo docker run hello-world

# Ajouter l'utilisateur courant au groupe docker pour utiliser Docker sans sudo (optionnel)
echo "Ajout de l'utilisateur $(whoami) au groupe docker..."
sudo usermod -aG docker $USER

# Terminer le script
echo "Installation de Docker terminée. Vous devrez peut-être redémarrer votre session pour utiliser Docker sans sudo."

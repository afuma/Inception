#!/bin/bash

# Dossier de destination pour les logs
LOG_DIR="./logs"

# Créer le dossier de logs s'il n'existe pas
mkdir -p "$LOG_DIR"

# Copier les logs Nginx
docker cp nginx:/var/log/nginx/access.log "$LOG_DIR/nginx-access.log"
docker cp nginx:/var/log/nginx/error.log "$LOG_DIR/nginx-error.log"

# Copier les logs MariaDB
docker cp mariadb:/var/log/mysql/error.log "$LOG_DIR/mariadb-error.log"
docker cp mariadb:/var/log/mysql/general.log "$LOG_DIR/mariadb-general.log"
docker cp mariadb:/var/log/mysql/slow.log "$LOG_DIR/mariadb-slow.log"

# Copier les logs WordPress (PHP)
docker cp wordpress:/var/www/html/wp-content/logs/debug.log "$LOG_DIR/wordpress-debug.log"

echo "Tous les logs ont été récupérés dans $LOG_DIR."

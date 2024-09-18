#!/bin/bash

# Attendre 10 secondes pour s'assurer que les services nécessaires (comme la base de données) sont en ligne
sleep 10

# Créer wp-config.php si nécessaire
if [ ! -f /var/www/wordpress/wp-config.php ]; then
  wp config create --allow-root \
                   --dbname="$SQL_DATABASE" \
                   --dbuser="$SQL_USER" \
                   --dbpass="$SQL_PASSWORD" \
                   --dbhost="mariadb:3306" \
                   --path='/var/www/wordpress'
fi

# Vérifier si le dossier /run/php existe, sinon le créer
[ -d /run/php ] || mkdir -p /run/php

# Lancer la configuration WordPress
wp core install --allow-root \
                --url="http://example.com" \
                --title="Mon Site" \
                --admin_user="admin" \
                --admin_password="password" \
                --admin_email="admin@example.com" \
                --path='/var/www/wordpress'

# Créer un deuxième utilisateur WordPress
wp user create seconduser user@example.com --role=editor --user_pass=password --allow-root --path='/var/www/wordpress'

# Lancer PHP-FPM
/usr/sbin/php-fpm7.3 -F

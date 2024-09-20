#!/bin/bash

# Attendre 10 secondes pour s'assurer que les services nécessaires (comme la base de données) sont en ligne
sleep 5

cd /var/www/wordpress #peut etre pas necessaire
FILE=/var/www/wordpress/wp-config.php
# Créer wp-config.php si nécessaire
if [ ! -f "$FILE" ]; then
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
                --url=https://${DOMAIN_NAME} \
                --title=${SITE_TITLE} \
                --admin_user=${ADMIN_USER} \
                --admin_password=${ADMIN_PASSWORD} \
                --admin_email=${ADMIN_EMAIL}

# Créer un deuxième utilisateur WordPress
wp user create --allow-root ${USER1_LOGIN} ${USER1_MAIL} \
	--role=author \
	--user_pass=${USER1_PASS}

# Lancer PHP-FPM
/usr/sbin/php-fpm7.3 -F

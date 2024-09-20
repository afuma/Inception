#!/bin/bash

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
	./wp-cli.phar config create	
				--path=/var/www/wordpress --allow-root \
				--dbname=$SQL_DATABASE \
				--dbuser=$SQL_USER \
				--dbpass=$SQL_PASSWORD \
				--dbhost=$SQL_HOST
fi

./wp-cli.phar core install	--allow-root \
    --url=https://${DOMAIN_NAME} \
    --title=${SITE_TITLE} \
    --admin_user=${ADMIN_USER} \
    --admin_password=${ADMIN_PASSWORD} \
    --admin_email=${ADMIN_EMAIL};
./wp-cli.phar user create	--allow-root ${USER1_LOGIN} ${USER1_MAIL}\
        --role=author \
        --user_pass=${USER1_PASS};

mkdir -p /run/php

php-fpm7.4 -F 

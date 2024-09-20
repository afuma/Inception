#!/bin/sh

# Vérification des permissions sur les répertoires
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld /var/log/mysql

# Démarrage de MariaDB en mode sécurisé
mysqld_safe &

# Attendre que le serveur MariaDB soit disponible
until mysqladmin ping >/dev/null 2>&1; do
    sleep 1
done

# Création de la base de données et des utilisateurs
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "DROP DATABASE IF EXISTS test;"
mysql -e "FLUSH PRIVILEGES;"

# Arrêt sécurisé du serveur MariaDB
mysqladmin shutdown

# Démarrage du serveur MariaDB
exec mysqld_safe

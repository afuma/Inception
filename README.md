#!/bin/sh

MYSQL_DATABASE=${SQL_DATABASE}
MYSQL_USER=${SQL_USER}
MYSQL_PASSWORD=${SQL_PASSWORD}
MYSQL_ROOT_PASSWORD=${SQL_ROOT_PASSWORD}

# Assurer les permissions correctes
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

# Initialiser MariaDB si nécessaire
if [ ! -d /var/lib/mysql/$MYSQL_DATABASE ]; then
    echo "Initializing database..."
    mysqld --initialize-insecure --user=mysql
    echo "Database initialized."

    # Créer un fichier temporaire pour les commandes SQL
    tfile=$(mktemp)
    if [ ! -f "$tfile" ]; then
        echo "Error: Could not create temp file."
        exit 1
    fi

    cat << EOF > $tfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

    # Lancer MariaDB en mode bootstrap
    /usr/sbin/mysqld --user=mysql --bootstrap --skip-name-resolve --skip-networking=0 < "$tfile"
    rm -f "$tfile"
    echo "Database setup complete."
fi

# Démarrer MariaDB en avant-plan
exec /usr/sbin/mysqld --user=mysql --console --skip-name-resolve --skip-networking=0

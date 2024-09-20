FROM debian:bullseye

ARG M_USER=mysql

RUN apt-get update && apt-get install -y bash curl vim mariadb-server mariadb-client

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Créer les répertoires et appliquer les permissions sous root
RUN mkdir -p /var/run/mysqld && \
    mkdir -p /var/lib/mysql && \
    mkdir -p /var/log/mysql && \
    chown -R ${M_USER}:${M_USER} /var/run/mysqld /var/lib/mysql /var/log/mysql && \
    chmod -R 755 /var/run/mysqld /var/lib/mysql /var/log/mysql && \
    mysql_install_db --user=${M_USER} --datadir=/var/lib/mysql

# Supprimer les fichiers corrompus (toujours sous root)
RUN rm -f /var/lib/mysql/ibdata1 /var/lib/mysql/ib_logfile*

COPY ./tools/ .

RUN chown ${M_USER}:${M_USER} ./dbscript.sh && \
chmod +x ./dbscript.sh

# Maintenant, basculer vers l'utilisateur mysql
USER ${M_USER}:${M_USER}

EXPOSE 3306

ENTRYPOINT ["./dbscript.sh"]




# RUN apt-get update
# RUN apt-get upgrade -y
# RUN apt-get install -y mariadb-server mariadb-client
# RUN apt install vim -y
# RUN apt install curl -y
# COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
# RUN mkdir -p /var/run/mysqld
# RUN mkdir -p /var/lib/mysql
# RUN chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
# RUN chmod -R 755 /var/lib/mysql /var/run/mysqld
# EXPOSE 3306
# COPY ./tools/dbscript.sh ./
# RUN chmod +x ./dbscript.sh
# ENTRYPOINT ["./dbscript.sh"]
# CMD ["mysqld_safe"]
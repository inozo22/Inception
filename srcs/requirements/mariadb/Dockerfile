FROM alpine:3.16

# WHAT I HAVE TO DO ######
# Download mariadb-server && mariadb-client

RUN apk update && apk upgrade 
RUN apk add --no-cache mariadb \
    mariadb-client mariadb-common 
RUN rm -rf /var/cache/apk/*

# To run mariaDB on your container, you have to copy your .sh and the .sql on the /var/local/bin/

COPY ./tools/setup.sh /usr/local/bin/

# Give the right to execute your mysqld (which is the daemon for mysql)

RUN chmod +x /usr/local/bin/setup.sh

# Launch your script to install mariaDB
# Then do a CMD to enable the database to listen to all the IPV4 adresses.





# Any additional configurations for MariaDB
# COPY my.cnf /etc/mysql/my.cnf

COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

ENTRYPOINT [ "setup.sh" ]
RUN echo "setup.sh in mariadb executed"

# Healthcheck to ensure MariaDB is running
CMD [ "/usr/bin/mysqld", "--user=mysql", "--console" ]



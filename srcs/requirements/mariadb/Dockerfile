FROM alpine:3.16

RUN apk update && apk upgrade 
RUN apk add --no-cache mariadb \
    mariadb-client mariadb-common 
RUN rm -rf /var/cache/apk/*

# To run mariaDB on your container, you have to copy your .sh and the .sql on the /var/local/bin/

COPY ./tools/setup.sh /usr/local/bin/

# Give the right to execute your mysqld (which is the daemon for mysql)

RUN chmod +x /usr/local/bin/setup.sh

COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

# Healthcheck to ensure MariaDB is running
HEALTHCHECK CMD ["mysqladmin", "ping", "-h", "localhost", "-u", "root", "-ppassword"]


ENTRYPOINT [ "setup.sh" ]

CMD [ "/usr/bin/mysqld", "--user=mysql", "--console" ]
RUN echo "setup.sh in mariadb executed"

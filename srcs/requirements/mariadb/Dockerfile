FROM alpine:3.16.9

RUN apk update && apk upgrade 

# Installs Mariadb and related packages, with the --no-cache option to avoid caching package files,
# and removes the package cache to reduce the image size afterword.
RUN apk add --no-cache mariadb \
    mariadb-client mariadb-common 
RUN rm -rf /var/cache/apk/*

# Copies the setup.sh script from the local directory.
COPY ./tools/setup.sh /usr/local/bin/

# Grants execute permissions to the setup.sh.
RUN chmod +x /usr/local/bin/setup.sh

# Copies the mariadb-server.cnf configuration file to the appropiate directory in the container.
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

# Defines a health check command o verify that MariaDB is running with the root account and the 
# specified password.
HEALTHCHECK CMD ["mysqladmin", "ping", "-h", "localhost", "-u", "root", "-p${MYSQL_ROOT_PASSWORD}"]

# Specifies the default command to run when the container starts, setting it to execute the setup.sh.
ENTRYPOINT [ "setup.sh" ]

# Defines the default command to run if no command is provided during container startup.
# It starts the MariaDB daemon (mysql) with specific user and console options.
CMD [ "/usr/bin/mysqld", "--user=mysql", "--console" ]
RUN echo "setup.sh in mariadb executed"

FROM mariadb:10.5.13

# Any additional configurations for MariaDB
# COPY my.cnf /etc/mysql/my.cnf

# Healthcheck to ensure MariaDB is running
HEALTHCHECK CMD ["mysqladmin", "ping", "-h", "localhost"]
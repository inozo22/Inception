FROM mariadb:10.5.13

# Any additional configurations for MariaDB
# COPY my.cnf /etc/mysql/my.cnf

# Healthcheck to ensure MariaDB is running
HEALTHCHECK CMD ["mysqladmin", "ping", "-h", "localhost"]



# WHAT I HAVE TO DO ######
# Download mariadb-server && mariadb-client
# To run mariaDB on your container, you have to copy your .sh and the .sql on the /var/local/bin/
# Give the right to execute your mysqld (which is the daemon for mysql)
# Launch your script to install mariaDB
# Then do a CMD to enable the database to listen to all the IPV4 adresses.
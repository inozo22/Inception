#!/bin/sh

# wait until database is ready
# This loop waits for the MariaDB database to become available by attempting to connect to it using mariadb command. 
# It waits for 10 seconds between each attempt.
while ! mariadb -h$MYSQL_HOST -u$WP_DB_USER -p$WP_DB_PASSWORD $WP_DB_NAME --silent; do
	echo "[i] waiting database connection..."
	sleep 10;
done
echo "after waiting mariadb: Am I??"

# check if wordpress is installed
# If WordPress is already installed by looking for the presence of a file ($WP_FILE_ONINSTALL). 
# If not, it proceeds to download and install WordPress using wp-cli. 
# It then creates a configuration, installs WordPress, creates an admin user, updates plugins, and moves files around. 
# Finally, it touches the file indicating that WordPress has been installed.
if [ ! -f "/var/www/html/$WP_FILE_ONINSTALL" ]; then
	echo "[i] wordpress installing...[1]"

	# wp-cli
  # wp core download --allow-root
  echo "[i] wordpress expanding..."
  tar -xzvf /tmp/wordpress-6.2.tar.gz -C /var/www/html/ >/dev/null && chmod -R 755 /var/www/html/wordpress
  cd /var/www/html/wordpress
  echo "[i] config creating..."
	wp config create \
    --dbname=$WP_DB_NAME \
    --dbuser=$WP_DB_USER \
    --dbpass=$WP_DB_PASSWORD \
		--dbhost=$MYSQL_HOST \
    --dbcharset="utf8" \
    --dbcollate="utf8_general_ci" \
    --allow-root
  echo "[i] wordpress installing...[2]"
	wp core install \
    --url=$DOMAIN_NAME \
    --title=$WP_TITLE \
    --admin_user=$WP_ADMIN_USER \
		--admin_password=$WP_ADMIN_PASSWORD \
    --admin_email=$WP_ADMIN_EMAIL \
    --skip-email \
    --allow-root
  echo "[i] user creating..."
	wp user create \
    $WP_USER $WP_EMAIL \
    --role=author \
    --user_pass=$WP_PASSWORD \
    --allow-root

	# update plugins
  wp plugin update --all --allow-root

  mv /tmp/index.html /var/www/html/wordpress
	touch /var/www/html/$WP_FILE_ONINSTALL
fi

mkdir -p /var/run/php-fpm7
#mkdir -p /var/run/php-fpm8
echo "[i] => Done wordpress setup!"

#The script ends with exec "$@", which allows the script to execute any command-line
# arguments provided when running the script.
exec "$@"

FROM wordpress:5.9-php7.4-fpm-alpine

# Any additional configurations for WordPress and php-fpm
# COPY php.ini /usr/local/etc/php/conf.d/php.ini

# Healthcheck to ensure php-fpm is running
HEALTHCHECK CMD ["php-fpm", "-t"]
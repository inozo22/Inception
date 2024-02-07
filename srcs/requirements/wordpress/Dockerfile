FROM alpine:3.16

# WHAT I HAVE TO DO
# Download php-fpm

RUN apk update && apk upgrade 
RUN apk add --no-cache php php-fpm \
    php-mysqli \
    php-opcache \
    php-bcmath \
    php-exif \
    php-gd \
    php-curl \
    php-json \
    php-mbstring \
    php-intl \
    php-xml \
    php-zip \
    php-openssl \
    php-pear \
    php-phar \
    php-zip \
    php-zlib \
    mariadb-client \
    curl \
    ca-certificates \
    tar \
    wget \
    bash \
    less 

# Copy the www.conf file /etc/php7.4/php-fpm.d



COPY ./conf/php-fpm.conf /etc/php7.4/php-fpm.conf
COPY ./conf/www.conf /etc/php7.4/php-fpm.d/www.conf

# Create the php directory to enable php-fpm to run

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp && chmod +x /usr/local/bin/wp



# Copy the script and launch it

COPY ./tools/setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup.sh


# Go to the html directory

COPY ./tools/wordpress-6.2.tar.gz /tmp/
COPY ./tools/index.html /tmp/
RUN chmod -R 777 /tmp/

ENTRYPOINT [ "setup.sh" ]


# Launch php-fpm



# Any additional configurations for WordPress and php-fpm
# COPY php.ini /usr/local/etc/php/conf.d/php.ini

# Healthcheck to ensure php-fpm is running
CMD [ "php-fpm7.4", "--nodaemonize" ]

FROM alpine:3.16.9

RUN apk update && apk upgrade
RUN apk add --no-cache php8 php8-fpm \
    php8-mysqli \
    php8-opcache \
    php8-bcmath \
    php8-exif \
    php8-gd \
    php8-curl \
    php8-json \
    php8-mbstring \
    php8-intl \
    php8-xml \
    php8-zip \
    php8-openssl \
    php8-pear \
    php8-phar \
    php8-zip \
    php8-zlib \
    mariadb-client \
    curl \
    ca-certificates \
    tar \
    wget \
    bash \
    less 

# Create a user nginx and add group in nginx
RUN adduser -S nginx && addgroup -S nginx

COPY ./conf/php-fpm.conf /etc/php8/php-fpm.conf
COPY ./conf/www.conf /etc/php8/php-fpm.d/www.conf

# Create the php directory to enable php-fpm to run

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
RUN chmod +x wp-cli.phar 
RUN mv wp-cli.phar /usr/local/bin/wp && chmod +x /usr/local/bin/wp

# Copy the script and give permission
COPY ./tools/setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup.sh

# Copy the wordpress's tar file and give permission
COPY ./tools/wordpress-6.2.tar.gz /tmp/
RUN chmod -R 777 /tmp/

# Launch setup.sh
ENTRYPOINT [ "setup.sh" ]

CMD [ "php-fpm8", "--nodaemonize" ]

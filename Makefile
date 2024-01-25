NGINX_IMAGE = nginx-custom
WORDPRESS_IMAGE = wordpress-custom
MARIADB_IMAGE = mariadb-custom

all:
    docker-compose -f srcs/docker-compose.yml up -d --build

down:
    docker-compose down

.PHONY: all down
.SILENT:

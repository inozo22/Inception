FROM alpine:3.16

# apk
RUN apk update && apk upgrade && apk add --no-cache nginx openssl


# Expose the necessary ports
#EXPOSE 80
#EXPOSE 443

# open ssl certificate
# create the SSL directory
RUN mkdir /etc/nginx/ssl
# generate SSL key and certificate
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=JP/ST=urduliz/L=city/0=42urduliz/CN=nimai.42.fr"



# nginx
RUN mkdir -p /run/nginx
# Your NGINX configurations with TLSv1.2 or TLSv1.3
# COPY nginx.conf /etc/nginx/nginx.conf

COPY ./conf/default.conf /etc/nginx/http.d/default.conf


# Healthcheck to ensure NGINX is running
HEALTHCHECK CMD ["nginx", "-g", "daemon off;"]


# FROM  - defines a base for your image. exemple : FROM debian
# RUN - executes any commands in a new layer on top of the current image and commits the result. RUN also has a shell form for running commands.
# WORKDIR - sets the working directory for any RUN, CMD, ENTRYPOINT, COPY, and ADD instructions that follow it in the Dockerfile. (You go directly in the directory you choose)
# COPY - copies new files or directories from and adds them to the filesystem of the container at the path .
# CMD - lets you define the default program that is run once you start the container based on this image. Each Dockerfile only has one CMD, and only the last CMD instance is respected when multiple ones exist.


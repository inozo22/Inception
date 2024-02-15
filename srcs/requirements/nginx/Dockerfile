FROM alpine:3.16.9

RUN apk update && apk upgrade 
RUN apk add --no-cache nginx openssl

# open ssl certificate
# create the SSL directory
RUN mkdir /etc/nginx/ssl
# generate SSL key and certificate
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=ES/ST=urduliz/L=city/0=42urduliz/CN=nimai.42.fr"

# Crate a directory for nginx
RUN mkdir -p /run/nginx

COPY ./conf/default.conf /etc/nginx/http.d/default.conf

# Healthcheck to ensure NGINX is running
CMD ["nginx", "-g", "daemon off;"]

FROM nginx:1.20.2-alpine

# Your NGINX configurations with TLSv1.2 or TLSv1.3
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose the necessary ports
EXPOSE 80
EXPOSE 443

# Healthcheck to ensure NGINX is running
HEALTHCHECK CMD ["nginx", "-g", "daemon off;"]
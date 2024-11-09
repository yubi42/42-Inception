# Use Alpine Linux as the base image for NGINX
FROM alpine:3.18

# Install NGINX & OpenSSL
RUN apk update && apk add nginx openssl

# Addjusting ngnix config
RUN mkdir -p /etc/nginx/http.d/
COPY conf/default.conf /etc/nginx/http.d/

# Creating SSL Ket and Certificate
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
  -subj "/C=DE/ST=Berlin/L=Berlin/O=42/OU=42/CN=jborner.42.fr/UID=jborner/"

# Expose port 443 for HTTP
EXPOSE 443

# Start NGINX in the foreground
ENTRYPOINT ["nginx", "-g", "daemon off;"]

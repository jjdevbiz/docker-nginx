#
# Nginx Dockerfile
#
# https://github.com/jjdevbiz/docker-nginx

# Pull base image.
FROM alpine:3.3

# update centos
RUN \
apt-get update && \
apt-get upgrade -y

# install deps
RUN \
apt-get -y install nginx

# Define mountable directories.
# VOLUME ["/etc/nginx/ssl", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Add docker user, Start SSH
RUN useradd -d /etc/nginx -s /bin/sh nginx

# Expose ports.
EXPOSE 80
EXPOSE 443

USER nginx

# Define working directory.
WORKDIR /etc/nginx

# Define default command.
CMD nginx -c /etc/nginx/nginx.conf

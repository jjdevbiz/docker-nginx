#!/bin/bash

mkdir -p /etc/nginx/ssl
mkdir -p /etc/nginx/conf.d
mkdir -p /var/log/nginx
mkdir -p /var/www/html

docker run --name dragonborn_nginx -p 80:80 -p 443:443 -v /var/log/nginx:/var/log/nginx -v /var/www/html:/var/www/html -v /etc/nginx:/etc/nginx dragonborn/nginx

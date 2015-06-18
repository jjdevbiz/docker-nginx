# Nginx Dockerfile - centos6.6 - nginx 1.8.0
```
docker build -t nginx_centos .
docker run -d -p 55555:22 -p 80:80 -p 443:443 -v <sites-enabled-dir>:/etc/nginx/conf.d -v <certs-dir>:/etc/nginx/ssl -v <log-dir>:/var/log/nginx -v <html-dir>:/var/www/html jjdevbiz/docker-nginx
```

## Start ##

*~/.ssh/config entry for easy ssh*
```
Host docker-nginx
  User      docker
  Port      55555
  HostName  127.0.0.1
  RemoteForward 64713 localhost:4713
```

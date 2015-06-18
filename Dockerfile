#
# Nginx Dockerfile - centos6.6 - nginx 1.8.0
#
# https://github.com/jjdevbiz/docker-nginx
#

# Pull base image.
FROM centos:6.6

# update centos
RUN \
yum repolist && \
yum upgrade -y && \

# add nginx repo
RUN \
echo "[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/OS/OSRELEASE/$basearch/
gpgcheck=1
enabled=1" > /etc/yum.repos.d/nginx.repo
ADD http://nginx.org/keys/nginx_signing.key /opt/nginx_signing.key
RUN \
rpm --import /opt/nginx_signing.key

# install deps
RUN \
yum install -y openssl openssh-server && \

# Install Nginx.
RUN \
yum -y install nginx

# Define mountable directories.
VOLUME ["/etc/nginx/ssl", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Define working directory.
WORKDIR /etc/nginx

# Define default command.
CMD ["nginx"]

# Add docker user, Start SSH
RUN useradd -m -d /home/docker docker
RUN echo "docker:docker" | chpasswd
RUN mkdir -p /var/run/sshd
ENTRYPOINT ["/usr/sbin/sshd",  "-D"]

# Expose ports.
EXPOSE 22
EXPOSE 80
EXPOSE 443

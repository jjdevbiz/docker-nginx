#
# Nginx Dockerfile - centos6.6 - nginx 1.8.0
#
# https://github.com/jjdevbiz/docker-nginx
#

# Pull base image.
FROM centos:6.6

## add epel
#ADD https://www.elrepo.org/RPM-GPG-KEY-elrepo.org /opt/RPM-GPG-KEY-elrepo.org
#ADD http://www.elrepo.org/elrepo-release-6-6.el6.elrepo.noarch.rpm /opt/elrepo-release-6-6.el6.elrepo.noarch.rpm
#RUN \
#echo "73c7146c576a76a89f2eac538d142bbb1c898ca8203105e07a57b070355d3e1b728b735ccd09efbb98cc1cfd069233d396ff851c54f97e715fb7d44a3ad0e2b4  RPM-GPG-KEY-elrepo.org" > /opt/RPM-GPG-KEY-elrepo.org.sha512sum && \
#echo "be59be382141473ce0590a118fe6a3c8ec234c62a726fa0b05d841aef02150083e677465c4a23394c9fa9bc787a9c86bf149c86a891b3f2f5619d90be8961289  elrepo-release-6-6.el6.elrepo.noarch.rpm" > /opt/elrepo-release-6-6.el6.elrepo.noarch.rpm.sha512sum && \
#cd /opt && \
#sha512sum -c RPM-GPG-KEY-elrepo.org.sha512sum && \
#sha512sum -c elrepo-release-6-6.el6.elrepo.noarch.rpm.sha512sum && \
#rpm --import /opt/RPM-GPG-KEY-elrepo.org && \
#rpm -Uvh /opt/elrepo-release-6-6.el6.elrepo.noarch.rpm

# update centos
RUN \
yum repolist && \
yum upgrade -y

# install deps
RUN \
yum install -y openssl openssh-server

# add nginx repo
ADD http://nginx.org/keys/nginx_signing.key /opt/nginx_signing.key
RUN \
echo "5ae833b1505b1fe5414f02172729073e9ba5a6de0dd2acdaf52b7bc53d047d48adbbc9885b4c58838db5c8bc630a7d9ca0133b80eb6ca745369df76bc0124303  nginx_signing.key" > /opt/nginx_signing.key.sha512sum && \
cd /opt && \
sha512sum -c nginx_signing.key.sha512sum && \
rpm --import /opt/nginx_signing.key && \
echo -e "[nginx]\nname=nginx repo\nbaseurl=http://nginx.org/packages/centos/6/\$basearch/\ngpgcheck=1\nenabled=1" > /etc/yum.repos.d/nginx.repo

# Install Nginx.
RUN \
yum repolist && \
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

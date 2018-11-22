# docker run -it --rm --name doc -v /var/run/docker.sock:/var/run/docker.sock -v C:\gh\dockerfiles\legacylamp\:/home/legacylamp:ro docker

# build image : docker build -t "test:latest" .
# docker rm -f test ; docker image rm -f test ; docker build -t test . ; docker run -it --name test test
# setup container : docker run -it --privileged --name fb test
# exec bash : docker exec -it fb /bin/bash

FROM ubuntu:16.04
LABEL maintainer="cboudereau"

ARG USER=dev
ARG PASSWORD=ChangeMe
ARG PHP_VERSION=5.6
ARG MYSQL_ROOT_PW=$PASSWORD
ARG MYSQL_INSTALL_VERSION=

RUN apt-get update -y && apt-get install -y \
sudo \
whois \
apt-utils \
&& addgroup $USER \
&& echo "$PASSWORD\n$PASSWORD" | passwd root \
&& useradd -m -p $(mkpasswd -m sha-512 $PASSWORD) --home /home/$USER -g $USER -s /bin/bash $USER \
&& usermod -aG sudo $USER \
&& echo "Etc/UTC" > /etc/timezone

USER dev

COPY docker-entrypoint.sh /usr/local/bin

RUN echo $PASSWORD | sudo -S -- sudo chown $USER:$USER /usr/local/bin/docker-entrypoint.sh \
&& sudo chmod +x /usr/local/bin/docker-entrypoint.sh \
&& sudo apt-get install -y \ 
software-properties-common \
dialog \
&& LC_ALL=C.UTF-8 sudo add-apt-repository -y ppa:ondrej/php \
&& export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
&& echo "mysql-server$MYSQL_INSTALL_VERSION mysql-server/root_password password $MYSQL_ROOT_PW" | sudo debconf-set-selections \
&& echo "mysql-server$MYSQL_INSTALL_VERSION mysql-server/root_password_again password $MYSQL_ROOT_PW" | sudo debconf-set-selections \
&& sudo apt-get update -y && sudo apt-get install -y \
git \ 
vim \
links \
lsof \
locales \
# webserver packages
apache2 \
openssh-client \
openssh-server \
curl \
# php packages
php$PHP_VERSION \
libapache2-mod-php$PHP_VERSION \
php$PHP_VERSION-cli \
php$PHP_VERSION-curl \
php$PHP_VERSION-soap \
php$PHP_VERSION-common \
php$PHP_VERSION-mcrypt \
php$PHP_VERSION-mysql \
php$PHP_VERSION-gd \
php$PHP_VERSION-intl \
php$PHP_VERSION-xsl \
php$PHP_VERSION-xml \
php$PHP_VERSION-mbstring \
php$PHP_VERSION-dev \
php-xdebug \
php-pear \
php-gettext \
composer \
# MySql
mysql-common \
libdbd-mysql-perl \
mysql-client$MYSQL_INSTALL_VERSION \
mysql-server$MYSQL_INSTALL_VERSION
# Fix MySql file permission
RUN echo $PASSWORD | sudo -S -- chown -R mysql /var/lib/mysql && sudo chgrp -R mysql /var/lib/mysql \
&& sudo service mysql start \
# Apache configuration
&& sudo phpenmod mcrypt \
&& sudo a2enmod php$PHP_VERSION \
&& sudo a2enmod rewrite \ 
&& sudo a2enmod xml2enc \
&& sudo a2enmod proxy \
&& sudo a2enmod ssl \
&& sudo usermod -a -G $USER www-data \
&& sudo usermod -a -G www-data $USER \
&& sudo service apache2 restart \
# NodeJs
&& curl -sL https://deb.nodesource.com/setup_8.x | sudo bash - \
&& sudo apt install nodejs \
# Cleaning
&& sudo apt-get clean \
&& sudo passwd -l root && sudo passwd -d root \
# ssh folder for further ssh keys copy
&& mkdir ~/.ssh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["init"]
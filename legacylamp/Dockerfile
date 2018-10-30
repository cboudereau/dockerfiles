# docker cli for windows : docker run -it --rm --name doc -v /var/run/docker.sock:/var/run/docker.sock docker
# build image : docker build -t "test:latest" .
# setup container : docker run -it --privileged --name fb test
# exec bash : docker exec -it fb /bin/bash

# docker rm -f test ; docker image rm -f test ; docker build -t test . ; docker run -it --name test test

FROM ubuntu:16.04
LABEL maintainer="cboudereau"

ARG USER=dev
ARG PASSWORD=ChangeMe

RUN apt-get update -y && apt-get install -y \
sudo \
whois \
&& addgroup $USER \
&& echo "$PASSWORD\n$PASSWORD" | passwd root \
&& useradd -m -p $(mkpasswd -m sha-512 $PASSWORD) --home /home/$USER -g $USER -s /bin/bash $USER \
&& usermod -aG sudo $USER \
&& echo "Etc/UTC" > /etc/timezone

USER dev

COPY docker-entrypoint.sh /usr/local/bin

RUN echo $PASSWORD | sudo -S -- apt-get install -y \ 
software-properties-common \
dialog \
&& LC_ALL=C.UTF-8 sudo add-apt-repository -y ppa:ondrej/php \
&& export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
&& sudo apt-get update -y && sudo apt-get install -y \
git \
php5.6 \
&& sudo apt-get clean \
&& sudo passwd -l root && sudo passwd -d root

#ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
#CMD ["init"]
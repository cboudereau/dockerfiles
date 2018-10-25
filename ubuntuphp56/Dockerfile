FROM ubuntu:16.04
LABEL maintainer="cboudereau"

RUN apt-get update -y && apt-get install -y \
software-properties-common \
dialog \
whois \
sudo \
&& LC_ALL=C.UTF-8 sudo add-apt-repository -y ppa:ondrej/php \
&& export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
&& sudo echo "Etc/UTC" > /etc/timezone \
&& sudo apt-get update -y && sudo apt-get install -y \
git \
php5.6

ENTRYPOINT [ "/bin/bash" ]
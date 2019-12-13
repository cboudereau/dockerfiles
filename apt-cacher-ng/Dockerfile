# docker build -t apt-cacher-ng:latest .
# echo 'Acquire::http { Proxy "http://host.docker.internal:3142"; }' | tee -a /etc/apt/apt.conf.d/proxy


FROM debian:stretch
RUN apt-get update && apt-get install -y \
    apt-cacher-ng \
    && apt-get clean
EXPOSE 3142
VOLUME apt-cacher-ng:/var/cache/apt-cacher-ng
CMD service apt-cacher-ng start && tail -f /var/log/apt-cacher-ng/apt-cacher.*
##################################################################
# pimatic docker file
# VERSION              1.0 
##################################################################

# base image
FROM node:10

LABEL Description="Pimatic docker image" Maintainer="trebankosta@gmail.com" Version="1.0"

ENV DEBIAN_FRONTEND=noninteractive

####### install #######
RUN apt-get update ; apt-get install -y netcat-openbsd git make \
    build-essential libnss-mdns libavahi-compat-libdnssd-dev samba-common wakeonlan \
    libusb-dev libudev-dev curl libpcap-dev ca-certificates jq tzdata
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir /opt/pimatic-docker
RUN cd /opt && npm install pimatic --prefix pimatic-docker --production

####### init #######
RUN mkdir /data/
COPY ./config.json /data/config.json
RUN touch /data/pimatic-database.sqlite

####### volume #######
VOLUME ["/data"]
VOLUME ["/opt/pimatic-docker"]

ENV PIMATIC_DAEMONIZED=pm2-docker

####### command #######
CMD ln -fs /data/config.json /opt/pimatic-docker/config.json && \
   ln -fs /data/pimatic-database.sqlite /opt/pimatic-docker/pimatic-database.sqlite && \
   /etc/init.d/dbus start &&  \
   /etc/init.d/avahi-daemon start && \
   /usr/local/bin/nodejs /opt/pimatic-docker/node_modules/pimatic/pimatic.js

##################################################################
# pimatic docker file
# VERSION               0.3
##################################################################

# base image
FROM arm32v7/ubuntu

LABEL Description="Pimatic docker image for rpi3" Maintainer="trebankosta@gmail.com" Version="0.3"

ENV DEBIAN_FRONTEND=noninteractive

####### set default timezone ######
RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime

####### install #######
RUN apt update && apt-get -y upgrade
RUN apt-get install -y netcat-openbsd git make \
    build-essential libnss-mdns libavahi-compat-libdnssd-dev samba-common wakeonlan \
    libusb-dev libudev-dev curl libpcap-dev nodejs npm ca-certificates tzdata jq libpcap0.8-dev
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

####### command #######
CMD ln -fs /data/config.json /opt/pimatic-docker/config.json && \
   ln -fs /data/pimatic-database.sqlite /opt/pimatic-docker/pimatic-database.sqlite && \
   /etc/init.d/dbus start &&  \
   /etc/init.d/avahi-daemon start && \
   /usr/bin/nodejs /opt/pimatic-docker/node_modules/pimatic/pimatic.js

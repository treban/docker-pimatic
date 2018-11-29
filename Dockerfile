##################################################################
# pimatic docker file
# VERSION               0.1
##################################################################

# base image
FROM ubuntu:16.04

LABEL Description="Pimatic docker image" Maintainer="trebankosta@gmail.com" Version="0.1"

####### install #######
RUN apt-get update && apt-get -y upgrade 
RUN apt-get install -y --no-install-recommends npm nodejs git make \
    build-essential libnss-mdns libavahi-compat-libdnssd-dev samba-common wakeonlan \
    libusb-dev libudev-dev curl \
    && rm -rf /var/lib/apt/lists/*
    
RUN mkdir /opt/pimatic-docker
RUN cd /opt && npm install pimatic --prefix pimatic-docker --production

####### init #######
RUN mkdir /data/
COPY ./config.json /data/config.json

RUN touch /data/pimatic-database.sqlite
RUN ln -s /usr/bin/nodejs /usr/bin/node

####### volume #######
VOLUME ["/data"]
VOLUME ["/opt/pimatic-docker"]

####### command #######
CMD ln -fs /data/config.json /opt/pimatic-docker/config.json && \
   ln -fs /data/pimatic-database.sqlite /opt/pimatic-docker/pimatic-database.sqlite && \
   /usr/bin/nodejs /opt/pimatic-docker/node_modules/pimatic/pimatic.js   

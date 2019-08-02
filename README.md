## docker-pimatic

Docker Image for pimatic on intel plattforms.

for raspberry pi show [here...](https://hub.docker.com/r/treban/pimatic-rpi/)

[![Build Status](https://travis-ci.org/treban/docker-pimatic.svg?branch=master)](https://travis-ci.org/treban/docker-pimatic)
[![This image on DockerHub](https://img.shields.io/docker/pulls/treban/pimatic.svg)](https://hub.docker.com/r/treban/pimatic/)


### Pull the image

docker pull treban/pimatic

### TAGs 

* treban/pimatic:node4 = treban/pimatic:latest = treban/pimatic \
    pimatic with node4 base image
* treban/pimatic:node10 \
    pimatic with node10 base image

### Run the container

docker run \\ \
   -it \\ \
   --network=host \\ \
   -v /data-path:/data \\ \
   --device=/dev/ttyUSB0 \\ \
   treban/pimatic

You can specify a device for homeduino or some other usb devices.

The container needs a mounted volume in /data.
In this folder must be placed the config.json and the sql database.
The image otherwise uses the default pimatic config and 
generates a inital sql database

- config.json
- pimatic-database.sqlite

The pimatic app folder inside the container is /opt/pimatic-docker.
The default config exposes port 8282 and admin/admin as login credentials.

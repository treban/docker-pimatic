## docker-pimatic

Docker Image for pimatic on rasbperry pi 3 and other armv7 plattforms.

for intel show [here...](https://hub.docker.com/r/treban/pimatic/)

[![Build Status](https://travis-ci.org/treban/docker-pimatic.svg?branch=rpi3)](https://travis-ci.org/treban/docker-pimatic)
[![This image on DockerHub](https://img.shields.io/docker/pulls/treban/pimatic-rpi.svg)](https://hub.docker.com/r/treban/pimatic-rpi/)

### Pull the image

docker pull treban/pimatic-rpi

### Run the container

docker run \\ \
   -it \\ \
   --network=host \\ \
   -v /data-path:/data \\ \
   --device=/dev/ttyUSB0 \\ \
   treban/pimatic-rpi

You can specify a device for homeduino or some other usb devices.

The container needs a mounted volume in /data.
In this folder must be placed the config.json and the sql database.
The image otherwise uses the default pimatic config and 
generates a inital sql database

- config.json
- pimatic-database.sqlite

The pimatic app folder inside the container is /opt/pimatic-docker.
The default config exposes port 8282 and admin/admin as login credentials.

#### Git repo for raspberry
[here...](https://github.com/treban/docker-pimatic/tree/rpi3)

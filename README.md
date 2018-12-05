## docker-pimatic

[![Build Status](https://travis-ci.org/treban/docker-pimatic.svg?branch=rpi3)](https://travis-ci.org/treban/docker-pimatic)
[![This image on DockerHub](https://img.shields.io/docker/pulls/treban/pimatic-rpi.svg)](https://hub.docker.com/r/treban/pimatic-rpi/)


### Pull the image

docker pull treban/pimatic

### Run the container

docker run -i -t -P -v /path-to-data-on-host:/data treban/pimatic

The container needs a mounted volume in /data.
In this folder must be placed the config.json and the sql database.
The image otherwise uses the default pimatic config and 
generates a inital sql database

- config.json
- pimatic-database.sqlite

The pimatic app folder is /opt/pimatic-docker.
The image exposes port 4242.

### Environment variable
The images has a predefined variable to activate the healthcheck mechanism:
* HEALTHCHECK off [on/off] 

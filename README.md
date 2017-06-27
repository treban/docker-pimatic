## docker-pimatic

### Pull the image

docker pull treban/pimatic

### Run the container

docker run -i -t -P -p 4242:4242 -v /path-to-data-on-host:/data treban/pimatic

The container needs a mounted volume in /data. 
In this folder must be placed the config.json and the sql database
- config.json
- pimatic-database.sqlite
 
The pimatic folder is /opt/pimatic-docker.
The image exposed port is 4242

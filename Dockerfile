##################################################################
# pimatic docker file
##################################################################

# base image
FROM node:4

# Author
MAINTAINER treban

####### install #######
RUN mkdir /opt/pimatic-docker
RUN /usr/bin/env node --version
RUN cd /opt && npm install pimatic --prefix pimatic-docker --production
RUN cd /opt/pimatic-docker/node_modules/pimatic && npm link

####### autostart #######
RUN wget https://raw.githubusercontent.com/pimatic/pimatic/v0.9.x/install/pimatic-init-d && cp pimatic-init-d /etc/init.d/pimatic
RUN chmod +x /etc/init.d/pimatic
RUN chown root:root /etc/init.d/pimatic
RUN update-rc.d pimatic defaults

####### init #######
RUN mkdir /data/
CMD ln -s /data/config.json /opt/pimatic-docker/config.json
CMD ln -s /data/pimatic-database.sqlite /opt/pimatic-docker/pimatic-database.sqlite

CMD service pimatic start && bash

# Expose pimatic port e.g. 80
EXPOSE 4242

##################################################################
# pimatic docker file
##################################################################

# base image
FROM node:4

# Author
MAINTAINER treban

####### install #######
RUN mkdir /opt/pimatic
RUN /usr/bin/env node --version
RUN cd /opt && npm install pimatic --prefix pimatic --production
RUN cd /opt/pimatic/node_modules/pimatic && npm link

####### autostart #######
RUN wget https://raw.githubusercontent.com/pimatic/pimatic/v0.9.x/install/pimatic-init-d && cp pimatic-init-d /etc/init.d/pimatic
RUN chmod +x /etc/init.d/pimatic
RUN chown root:root /etc/init.d/pimatic
RUN update-rc.d pimatic defaults

####### init #######
RUN ln -s /data/config.json /opt/pimatic/config.json
RUN ln -s /data/pimatic-database.sqlite /opt/pimatic/pimatic-database.sqlite

service pimatic start && bash

# Expose pimatic port e.g. 80
EXPOSE 4242

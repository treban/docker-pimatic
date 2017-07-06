##################################################################
# pimatic docker file
# VERSION               0.1
##################################################################

LABEL Description="Pimatic docker image" Maintainer="trebankosta@gmail.com" Version="0.1"

# base image
FROM node:4

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
RUN cp /opt/pimatic-docker/node_modules/pimatic/config_default.json /data/config.json

#HEALTHCHECK --interval=1m -timeout=5s --start-period=2m \
# CMD curl -f http://localhost/ || exit 1

ENTRYPOINT ["/bin/bash"]

CMD ln -fs /data/config.json /opt/pimatic-docker/config.json && \
   ln -fs /data/pimatic-database.sqlite /opt/pimatic-docker/pimatic-database.sqlite && \
   service pimatic start && tail -f /dev/null

EXPOSE 80

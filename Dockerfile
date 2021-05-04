FROM debian:10-slim

# Meta data
LABEL decription="Ssecurelabs RetireJS image is to be used to verify that your NodeJS (NPM) project does not contain any deepency vunerabilities. Part of the Ssecurelabs security image series."

LABEL version="1.0" maintainer="Alex Akass <alex@akass.com>"
LABEL com.seccurelabs.retirejs.version="0.0.1-beta"
LABEL vendor1="Ssecurelabs"
LABEL vendor2="Ttestlabs"
LABEL com.seccurelabs.retirejs.release-date="2021-04-03"
LABEL com.seccurelabs.retirejs.version.is-production="False"

# Elovate our user
USER root

#Update debian 10 and make sure the dependacies we need are installed
RUN apt-get update && apt-get upgrade -y && \
                apt-get install -y curl software-properties-common

#We will always use the long term support version, 14.16.0
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

#Update debian 10 and make sure the dependacies we need are installed
RUN apt-get install -y nodejs

#install retireJS
RUN npm install -g retire

#user a non elovated user from this point onwards
RUN adduser node
USER node

#Set the project folder
WORKDIR /home/node/app

#  entry point to use retire JS
ENTRYPOINT ["retire"]
CMD ["--outputformat", "json", "."]

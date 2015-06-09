# -----------------------------------------------------------------------------
# blockmove/tvheadend
#
# docker build -f Dockerfile -t blockmove/tvheadend .
#
#
# 2015-06-09 : User-ID and Group-ID according to Host-System
# 2015-06-08 : Added timezone, locale
# 2015-06-07 : Init Project
# -----------------------------------------------------------------------------


FROM ubuntu:14.04

MAINTAINER Dieter Poesl <doc@poesl-online.de>

# Skip install dialogues
ENV DEBIAN_FRONTEND noninteractive
# Set Home-Directory
ENV HOME /

RUN \
    apt-get update &&\
    apt-get -y install apt-transport-https &&\
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 379CE192D401AB61 &&\
    echo deb https://dl.bintray.com/tvheadend/ubuntu unstable main | sudo tee -a /etc/apt/sources.list
    
RUN \
    apt-get update &&\
    apt-get install -y --force-yes tvheadend

#Adjust User-ID and Group-ID
#Change it according to your Host-System
RUN \
    usermod -u 1099 hts && \
    groupmod -g 1099 hts
    
#Setup locale
#Change to your location
RUN locale-gen de_DE.UTF-8
RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

#Setup timezone
#Change for your timezone
RUN echo "Europe/Berlin" > /etc/timezone; dpkg-reconfigure -f noninteractive tzdata

#Ports for tvheadend
EXPOSE 9981 9982

VOLUME /config 
VOLUME /recordings 
VOLUME /data 
VOLUME /logos 
VOLUME /timeshift

CMD ["/usr/bin/tvheadend","-C","-u","hts","-g","hts","-c","/config"]
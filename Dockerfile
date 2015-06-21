# -----------------------------------------------------------------------------
# blockmove/tvheadend
#
# docker build -f Dockerfile -t blockmove/tvheadend .
#
#
# 2015-06-21 : Changed User--ID and Group-ID to nobody (99)
#                      Cleanup
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
    
#Clean-Up    
RUN \    
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#Set User-ID and Group-ID to nobody (99)
RUN \
    usermod -u 99 hts && \
    groupmod -g 99 hts
    
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

VOLUME \
    /config \ 
    /recordings \ 
    /data \ 
    /logos \
    /timeshift

CMD ["/usr/bin/tvheadend","-C","-u","hts","-g","hts","-c","/config"]
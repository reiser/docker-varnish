FROM thomaswelton/ubuntu

MAINTAINER thomaswelton

RUN	echo 'deb http://archive.ubuntu.com/ubuntu precise main universe' > /etc/apt/sources.list
RUN	echo 'deb http://archive.ubuntu.com/ubuntu precise-updates universe' >> /etc/apt/sources.list
RUN apt-get update

#Prevent daemon start during install
RUN	echo '#!/bin/sh\nexit 101' > /usr/sbin/policy-rc.d && chmod +x /usr/sbin/policy-rc.d

# Varnish
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y varnish

RUN mkdir -p /etc/varnish/sites
ADD default.vcl /etc/varnish/default.vcl

# Install supervisor
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor
RUN mkdir -p /var/log/supervisor

ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD run.sh /run.sh
CMD ["/bin/bash", "/run.sh"]

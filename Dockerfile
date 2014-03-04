FROM thomaswelton.com:5000/ubuntu

MAINTAINER thomaswelton

RUN	echo 'deb http://archive.ubuntu.com/ubuntu precise main universe' > /etc/apt/sources.list
RUN	echo 'deb http://archive.ubuntu.com/ubuntu precise-updates universe' >> /etc/apt/sources.list
RUN apt-get update

#Prevent daemon start during install
RUN	echo '#!/bin/sh\nexit 101' > /usr/sbin/policy-rc.d && chmod +x /usr/sbin/policy-rc.d

# Varnish
RUN apt-get install -y varnish

ADD default.vcl /etc/varnish/default.vcl

ADD run.sh /run.sh
CMD ["/bin/bash", "/run.sh"]

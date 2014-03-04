#!/bin/bash
#
# Start the varnish server

# Copy env vars to file for permanent storage
env | grep _ >> /etc/environment

# Copy the varnish backend to the config file
echo 'backend default { .host = "$VARNISH_BACKEND_PORT_80_TCP_ADDR"; .port = "$VARNISH_BACKEND_PORT_80_TCP_PORT"; }' >> /etc/varnish/default.vcl

varnishd -f /etc/varnish/default.vcl  -a 0.0.0.0:80 -s malloc,1G -F

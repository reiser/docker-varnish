#!/bin/bash
#
# Start the varnish server

# Copy env vars to file for permanent storage
env | grep _ >> /etc/environment

echo -e "\nSaving ENV VARS...\n"
cat /etc/environment

# Copy the varnish backend to the config file
echo "backend default { .host = \"$VARNISH_BACKEND_PORT_80_TCP_ADDR\"; .port = \"$VARNISH_BACKEND_PORT_80_TCP_PORT\"; }" > /etc/varnish/sites/default.vcl

exec /usr/bin/supervisord -n

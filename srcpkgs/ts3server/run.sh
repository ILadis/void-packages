#!/bin/sh

# create user/group in advance like:
#   useradd -r -s /sbin/nologin -d /var/lib/ts3server/ -U ts3server

# on error "failed to register local accounting service: file exists" delete:
#   /dev/shm/7gbhujb54g8z9hu43jre8

export BOX86_LD_LIBRARY_PATH=/usr/lib/
export BOX86_ALLOWMISSINGLIBS=1
export TS3SERVER_LICENSE=accept

mkdir -p /var/lib/ts3server
chown ts3server:ts3server -R /var/lib/ts3server

mkdir -p /var/log/ts3server
chown ts3server:ts3server -R /var/log/ts3server

cd /var/lib/ts3server
exec chpst -u ts3server:ts3server box86 /usr/bin/ts3server inifile=/etc/ts3server.ini 2>&1


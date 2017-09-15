#!/bin/sh

autossh -i /home/proxy/.ssh/id_rsa -M 0 -N -g -o "ServerAliveInterval 60" -L 9998:${REMOTE_HOST}:${REMOTE_PORT} ${TUNNEL_USER}@${TUNNEL_HOST}

#!/bin/sh
server=sitebuilt.net
pat=/home/services/social-auth
echo $server:$pat
scp package.json root@$server:$pat
scp env.json root@$server:$pat
scp README.md root@$server:$pat
scp server.js root@$server:$pat
scp appid root@$server:$pat
scp app/* root@$server:$pat/app
scp views/* root@$server:$pat/views


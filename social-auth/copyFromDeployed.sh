#!/bin/sh
server=sitebuilt.net
pat=/home/services/social-auth
echo $server:$pat
scp root@$server:$pat/package.json package.json
scp root@$server:$pat/env.json env.json
scp root@$server:$pat/server.js server.js
scp -r root@$server:$pat/app .
scp -r root@$server:$pat/views .


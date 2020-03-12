#!/bin/sh
## mysqldump -uroot -p --opt timecards > sql/timecards.sql
scp -r ../s2gio root@sitebuilt.net:/home/services
scp -r ../s2gio root@parleyvale.com:/home/services

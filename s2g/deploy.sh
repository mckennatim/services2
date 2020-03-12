#!/bin/sh
## mysqldump -uroot -p --opt timecards > sql/timecards.sql
scp -r ../s2g root@sitebuilt.net:/home/services
scp -r ../s2g root@parleyvale.com:/home/services

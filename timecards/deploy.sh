#!/bin/sh
## mysqldump -uroot -p --opt timecards > sql/timecards.sql
scp -r ../timecards root@sitebuilt.net:/home/services
scp -r ../timecards root@parleyvale.com:/home/services

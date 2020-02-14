#!/bin/sh
echo "sending database $1"
read -p "Enter Your Password: "  pwd
echo "Welcome $pwd!"

mysqldump -uroot -p$pwd --opt $1 > $1.sql
mysql -uroot -p$pwd -h sitebuilt.net $1 < $1.sql
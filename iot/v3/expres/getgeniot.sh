#!/bin/sh
read -p "Enter Your Password: "  pwd
echo "Welcome $pwd!"
mysqldump -h sitebuilt.net -uroot -p$pwd --opt geniot > geniot.sql
mysql -uroot -p$pwd geniot < geniot.sql
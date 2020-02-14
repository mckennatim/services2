#!/bin/sh
echo "getting database $1"
read -p "Enter Your Password: "  pwd
echo "Welcome $pwd!"

mysqldump -h sitebuilt.net -uroot -p$pwd --opt $1 > $1.sql
mysql -uroot -p$pwd $1 < $1.sql
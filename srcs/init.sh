#!/bin/bash

service mysql start
service php7.3-fpm start
service nginx start

echo "CREATE USER 'ntomika'@'localhost' IDENTIFIED BY 'ntomika';"| mysql -u root --skip-password
echo "CREATE DATABASE wordpress;"| mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'ntomika'@'localhost';"| mysql -u root --skip-password
echo "FLUSH PRIVILEGES;"| mysql -u root --skip-password

bash

FROM 	debian:buster	

RUN		apt-get update && apt-get install -y \
		wget \
		mariadb-server \
		nginx \
		php7.3 \
		php-mysql \
		php-fpm \
		php-mbstring \
		openssl \
		&& rm -rf /var/lib/apt/lists/*

ENV		AUTOINDEX on

WORKDIR /var/www/html/

RUN		rm -rf index.nginx-debian.html
COPY	srcs/nginx/*.conf /tmp/

# NGINX
COPY	srcs/nginx/nginx.conf /etc/nginx/sites-available/default

# PHPMYADMIN
RUN 	wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz && \
		tar -xzvf phpMyAdmin-5.0.1-english.tar.gz && \
		mv phpMyAdmin-5.0.1-english phpmyadmin && \
		rm -rf phpMyAdmin-5.0.1-english.tar.gz
COPY	srcs/php_myadmin/config.inc.php /var/www/html/phpmyadmin/config.sample.inc.php

# WORDPRESS
RUN 	wget https://wordpress.org/latest.tar.gz && \
		tar -xvzf latest.tar.gz && \
		rm -rf latest.tar.gz
COPY	srcs/wordpress/wp_config.php /var/www/html/wordpress/wp-config-sample.php

# SSL Certificate Setting
RUN		openssl req -x509 -nodes -days 365 -subj "/C=RU/ST=Moscow/L=Moscow/O=21school/OU=ntomika/CN=localhost" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

# Change Authorization
RUN 	chown -R www-data:www-data /var/www/html

RUN		chmod -R 777 /var/www/

COPY 	srcs/*.sh ./

# Ports that needs to be exposed
EXPOSE 	80 443

CMD 	bash init.sh ; sleep infinity

#!/bin/bash

if [ "$AUTOINDEX" = "off" ] ;
then
    cp /tmp/nginx_off.conf /etc/nginx/sites-available/default ;
else
    cp /tmp/nginx.conf /etc/nginx/sites-available/default ;
fi

service nginx restart

bash
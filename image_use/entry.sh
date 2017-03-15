#!/usr/bin/env bash
if [ "$1" == '-ssl' ]; then
    conf_file='/usr/local/nginx-ssl.conf'
else
    conf_file='/usr/local/nginx.conf'
fi

if [ -f /usr/local/hosts ]; then
    while read line
    do
        sed -i "s/upstream backend {/upstream backend {\n\ \ \ \ \ \ \ \ server $line;/" $conf_file
    done < /usr/local/hosts
    mv $conf_file /usr/local/nginx/conf/nginx.conf

    # Start nginx service
    /usr/local/nginx/sbin/nginx -g "daemon off;"
else
    echo "Please mount the /usr/local/hosts file by -v option!"
    echo "E.g. docker run -v /tmp/hosts:/usr/local/hosts -p 8080:80 nginx-lb"
    echo "The hosts file should contain the host names (include port) to be load balanced by Nginx"
fi
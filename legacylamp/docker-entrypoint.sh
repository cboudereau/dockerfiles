#!/bin/bash
set -e

OLDPASSWORD=ChangeMe

if [ "$1" = 'init' ]; then
    
    echo -e $OLDPASSWORD | sudo -S -- chown -R mysql /var/lib/mysql && sudo chgrp -R mysql /var/lib/mysql
    sudo service apache2 restart
    sudo service mysql restart

    read -s -p "Enter a new password : " PASSWORD
    mysql -uroot -p$OLDPASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${PASSWORD}';"
    echo -e "$PASSWORD\n$PASSWORD" | sudo passwd dev

    exit
fi

exec "$@"
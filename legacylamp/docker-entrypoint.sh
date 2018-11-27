#!/bin/bash
set -e

OLDPASSWORD=ChangeMe

if [ "$1" = 'init' ]; then
    
    echo -e $OLDPASSWORD | sudo -S -- chown -R mysql /var/lib/mysql > /dev/null 2>&1 
    sudo chgrp -R mysql /var/lib/mysql > /dev/null 2>&1
    sudo service apache2 restart > /dev/null 2>&1
    sudo service mysql restart > /dev/null 2>&1

    read -s -p "Enter a new password : \n" PASSWORD
    mysql -uroot -p$OLDPASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${PASSWORD}';" > /dev/null 2>&1
    echo -e "$PASSWORD\n$PASSWORD" | sudo passwd dev > /dev/null 2>&1

    echo 'Start the container to finish the setup'
    exit
fi

exec "$@"
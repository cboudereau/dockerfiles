#!/bin/bash
set -e

OLDPASSWORD=ChangeMe

if [ "$1" = 'init' ]; then
    read -s -p "Enter a new password : " PASSWORD
    
    sudo service apache2 restart
    sudo service mysql restart

    mysql -uroot -p$OLDPASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${PASSWORD}';"
    echo $OLDPASSWORD | sudo -S -- echo hello sudo ! 
    echo -e "$PASSWORD\n$PASSWORD" | sudo passwd dev
fi

exec "$@"
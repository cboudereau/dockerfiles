#!/bin/bash
set -e

OLDPASSWORD=ChangeMe
FIRST_RUN=~/.container_initialized

if [ ! -f $FIRST_RUN ]; then
     
    echo -e $OLDPASSWORD | sudo -S -- chown -R mysql /var/lib/mysql > /dev/null 2>&1 
    sudo chgrp -R mysql /var/lib/mysql > /dev/null 2>&1
    sudo service apache2 restart > /dev/null 2>&1
    sudo service mysql restart > /dev/null 2>&1

    read -s -p "Enter a new password : " PASSWORD
    mysql -uroot -p$OLDPASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${PASSWORD}';" > /dev/null 2>&1
    echo -e "$PASSWORD\n$PASSWORD" | sudo passwd dev > /dev/null 2>&1

    echo -e '\nContainer configuration finished'
    echo "You can now run this commands:"
    echo "docker start $HOSTNAME /bin/bash"
    echo "docker exec -it $HOSTNAME /bin/bash"
    touch $FIRST_RUN
    exit
fi

tail -f /dev/null
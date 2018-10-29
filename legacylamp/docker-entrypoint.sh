#!/bin/bash
set -e

if [ "$1" = 'init' ]; then
    read -s -p "Enter a new password : " PASSWORD

    echo ChangeMe | sudo -S -- echo hello sudo ! 
    echo -e "$PASSWORD\n$PASSWORD" | sudo passwd root
    echo -e "$PASSWORD\n$PASSWORD" | sudo passwd dev
    su - dev
fi

exec "$@"
#!/bin/bash

USER=dev
read -s -p "Enter a password dor $USER user : " PASSWORD

echo -e "$PASSWORD\n$PASSWORD" | passwd root
echo -e "$PASSWORD\n$PASSWORD" | passwd $USER

su - $USER
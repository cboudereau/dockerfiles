#!/bin/bash
read -s -p "Enter a username : " USER
echo "\n"
read -s -p "Enter a password : " PASSWORD

echo -e "$PASSWORD\n$PASSWORD" | passwd root
useradd -m -p $(mkpasswd -m sha-512 $PASSWORD) -s /bin/bash $USER
usermod -aG sudo $USER
su - $USER
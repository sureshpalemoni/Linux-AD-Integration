#!/usr/bin/bash

sudo yum -y update

sudo yum -y install sssd realmd krb5-workstation samba-common-tools

#Provide the admin username and password for AD
sudo echo "admin password" | sudo realm join -U admin_user@example.com example.com --verbose

# normally users have login with fqdn like admin_user@example.com
# This is to allow user with out fqdn
sudo sed -i '/^use_fully_qualified_names/ s/True/False/' /etc/sssd/sssd.conf
sudo sed -i '/^fallback_homedir/ s/\/home.*/\/home\/\%u/' /etc/sssd/sssd.conf

# start the SSSD service
sudo systemctl start sssd.service

#restart the system
sudo init 6

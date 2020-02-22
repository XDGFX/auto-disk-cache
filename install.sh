#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

cp auto-disk-cache.service /etc/systemd/system/auto-disk-cache.service
chmod 644 /etc/systemd/system/auto-disk-cache.service

systemctl enable auto-disk-cache
systemctl start auto-disk-cache
systemctl status auto-disk-cache
#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

iptables -I INPUT -s $(w | grep root | head -n 1 | awk '{ print $3 }') -j ACCEPT
iptables -I INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -P INPUT DROP

cd /root
git clone https://github.com/cc2/linux-configs.git

/root/linux-configs/server_setup.sh

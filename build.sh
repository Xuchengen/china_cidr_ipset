#!/bin/bash

V_IPSET_NAME=CHINA:CIDR

sudo apt-get update
sudo apt-get install -y ipset

curl -LR -o CN-ip-cidr.txt "https://github.com/Hackl0us/GeoIP2-CN/raw/release/CN-ip-cidr.txt"

sudo ipset create $V_IPSET_NAME hash:net hashsize 2048 maxelem 1000000

#for item in $(cat CN-ip-cidr.txt); do
#    sudo ipset add $V_IPSET_NAME $item
#done

sudo ipset save $V_IPSET_NAME > china_cidr_ipset.txt

echo $pwd
ls -a
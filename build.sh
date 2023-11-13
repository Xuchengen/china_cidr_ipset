#!/bin/bash

V_IPSET_NAME=CHINA:CIDR

# 安装ipset
sudo apt-get update
sudo apt-get install -y ipset

# 创建目录
mkdir -p dist

# 下载中国IP段数据
curl -LR -o dist/CN-ip-cidr.txt "https://github.com/Hackl0us/GeoIP2-CN/raw/release/CN-ip-cidr.txt"

# 创建ipset集合
sudo ipset create $V_IPSET_NAME hash:net hashsize 2048 maxelem 1000000

for item in $(cat dist/CN-ip-cidr.txt); do
    sudo ipset add $V_IPSET_NAME $item
done

# 转储ipset文件
sudo ipset save $V_IPSET_NAME > dist/china_cidr_ipset.txt

# 去掉bucketsize尾巴(有些Linux版本不兼容)
V_STR=$(head -n1 dist/china_cidr_ipset.txt)
V_STR=$(echo $V_STR | sed 's/ bucketsize [0-9]* initval 0x[0-9a-f]*//')
$(sed -i "1s/.*/$V_STR/" dist/china_cidr_ipset.txt)
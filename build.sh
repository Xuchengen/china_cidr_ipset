#!/bin/bash
for item in $(cat CN-ip-cidr.txt); do
    echo $item
    exit 0
done
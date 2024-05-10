#!/bin/bash

# 复制daemons文件到其他文件夹
for ((i=2; i<=100; i++)); do
    cp etc/r1/daemons etc/r"$i"/
done


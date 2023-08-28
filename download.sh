#!/bin/bash

# 下载 clash 执行文件
clash_exe=clash-linux-arm64-2023.08.17
clash_gz=$clash_exe.gz

wget https://github.com/Dreamacro/clash/releases/download/premium/$clash_gz
gunzip $clash_gz
mv ./$clash_exe ./clash
chmod +x ./clash

# 下载 clash web UI
git clone -b gh-pages https://github.com/Dreamacro/clash-dashboard ui

# 下载 Country.mmdb 文件
wget https://github.com/Dreamacro/maxmind-geoip/releases/latest/download/Country.mmdb

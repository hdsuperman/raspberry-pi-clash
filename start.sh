#!/bin/bash

# 后台启动 clash
# nohup /opt/clash/clash -f /opt/clash/config.yaml -d /opt/clash/ > /dev/null 2>&1 &
nohup /opt/clash/clash -f /opt/clash/config.yaml -d /opt/clash/ 2>&1 | tee clash.log &
sleep 5 

# 这里 iptable 没有持久化，而是开机后才设置，避免污染全局，而且可以按需改动
# wifi hotspot -> clash redirect routes
iptables -t nat -N CLASH
iptables -t nat -A PREROUTING -p tcp -j CLASH
iptables -t nat -A CLASH -d 0.0.0.0/8 -j RETURN
iptables -t nat -A CLASH -d 10.0.0.0/8 -j RETURN
iptables -t nat -A CLASH -d 127.0.0.0/8 -j RETURN
iptables -t nat -A CLASH -d 169.254.0.0/16 -j RETURN
iptables -t nat -A CLASH -d 172.16.0.0/12 -j RETURN
iptables -t nat -A CLASH -d 192.168.0.0/16 -j RETURN
iptables -t nat -A CLASH -d 224.0.0.0/4 -j RETURN
iptables -t nat -A CLASH -d 240.0.0.0/4 -j RETURN
iptables -t nat -A CLASH -p tcp -j REDIRECT --to-ports 7892

# 启动 clash 和 clash dns 后再启动 WIFI 热点，避免 53 接口被 dnsmsqs 占用冲突问题
nmcli connection up Hotspot

#!/bin/bash

# 配置 WIFI 接入信息
echo "请输入 WIFI 热点名称："
read hotspot_name

echo "请输入 WIFI 热点密码："
read hotspot_password

# 开启本地解析服务，安装/配置好热点后关闭
systemctl start systemd-resolved

# 安装必要的网络管理工具
apt-get update
apt-get install network-manager net-tools

# 设置无线热点，使用 Hotspot 作为默认连接名
nmcli dev wifi hotspot ifname wlan0 con-name Hotspot ssid $hotspot_name password "$hotspot_password"
# 创建完成关闭连接，避免 dnsmsqs 占用 53 DNS 解析接口，在 start.sh 中启动
nmcli connection down Hotspot

# DNS 配置：关闭系统 resolve 服务，避免 53 端口冲突
systemctl disable systemd-resolved
systemctl stop systemd-resolved
sudo lsof -i :53

# 在主机上启用 IP 转发功能，然后运行 sysctl 命令应用
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
sysctl -p


# 检查 /etc/resolv.conf 是否存在，备份
if [ -e "/etc/resolv.conf" ]; then
    # 如果存在，则重命名为 resolve.conf.bak
    mv /etc/resolv.conf /etc/resolve.conf.bak
fi
# 修改 DNS 解析文件，配置 nameserver 为 127.0.0.1 
cp ./resolv.conf /etc/

# 设置开机启动，启动配置文件为 clash.service
cp ./clash.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable clash.service
systemctl start clash.service

# 查看路由
sudo iptables -t nat -L
# 查看 clash 端口占用
sudo netstat -tunpl | grep clash
# 查看 53 端口占用
sudo lsof -i :53

# 退出 clash
pkill -9 clash

# 显示 WIFI 热点名称密码：
nmcli dev wifi show-password

# 列出并删除
nmcli connection show
sudo nmcli connection delete Hotspot
sudo service NetworkManager restart

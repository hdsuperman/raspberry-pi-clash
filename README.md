# 树莓派 Clash 透明代理

链路如下：

```
WIFI 热点 -> 有线网口 -> 路由器 -> 互联网
```

支持：

1. 自动配置开机启动
2. 自动配置 WIFI 热点信息
3. 自动配置 Clash DNS，避免本地 systemd-resolved 或 dnsmasq 服务冲突 (关键)
4. 自动配置路由，可自定义修改

## 硬件和系统

树莓派 4B + Ubuntu Server 22 LTS (64bit)

## 简单使用

1. clone 仓库到本机 (网络能下载 github 文件)，执行 `./download.sh` 下载 clash 等依赖
2. 将账号信息填到 `config_example.yaml` 文件，重命名为 `config.yaml`
3. 将当前目录下文件拷贝到树莓派 `/opt/clash` 目录下 `scp -r * remote_pi@pi_host:/opt/clash/`
4. 执行 `sudo ./init.sh` 初始化树莓派配置，按提示填写信息即可

## 打开 Clash 控制台
找到树莓派的 IP 地址，访问 `http://ip:9090/ui/#/proxies` 即可打开控制台

## 注意 ⚠️

clash 启动 DNS 需要关闭 systemd-resolved 服务，如果需要 apt 安装更新依赖，关闭 clash，打开 systemd-resolved
再执行安装，原始 `/etc/resolv.conf` 文件备份在 `/etc/resolv.conf.bak`，如果需要恢复，执行

```shell
sudo mv /etc/resolv.conf.bak /etc/resolv.conf
sudo systemctl start systemd-resolved
```

#!/bin/bash

# 更新系统和安装 Docker
sudo yum update -y
sudo yum install -y docker

# 启动 Docker 服务并设置为开机启动
sudo service docker start
sudo chkconfig docker on

# 等待 Docker 服务完全启动
while ! sudo docker info > /dev/null 2>&1; do
  echo "Waiting for Docker to launch..."
  sleep 1
done

# 添加用户到 Docker 组（可能需要重新登录才能生效）
sudo usermod -a -G docker ec2-user

# 运行 Nginx 容器
sudo docker run -d --name nginx -p 80:80 nginx

# 运行 Shadowsocks Rust 服务端
sudo docker run --name ssserver-rust \
  --restart always \
  -p 5000:5000/tcp \
  -p 5000:5000/udp \
  -dit ghcr.io/shadowsocks/ssserver-rust:latest \
  ssserver -s "0.0.0.0:5000" -m "aes-256-gcm" -k "${password}"

# 运行 Shadowsocks Rust 客户端
sudo docker run --name sslocal-rust \
  --restart always \
  -p 3120:3120/tcp \
  -dit ghcr.io/shadowsocks/sslocal-rust:latest \
  sslocal -b "0.0.0.0:3120" --protocol http -s "172.17.0.2:5000" -m "aes-256-gcm" -k "${password}"
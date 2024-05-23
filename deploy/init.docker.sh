# 1. 安装Docker
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# 2. 安装docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m` -o /usr/sbin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

## 3. 创建自定义网络
#sudo docker network create --subnet=172.20.0.0/24 suiteboot-network
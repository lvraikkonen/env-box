## 准备

1. 创建zkNet的docker网络

``` shell
docker network create --driver bridge --subnet 172.40.0.0/25 --gateway 172.40.0.1  zookeeper_network
```

2. 创建挂载文件夹

``` shell
mkdir -p zknode1/data zknode2/data zknode3/data
mkdir -p zknode1/log zknode2/log zknode3/log
```

## 启动zk集群测试

``` shell
docker-compose up -d

docker exec -it zknode1 /bin/bash

zkServer.sh status
```


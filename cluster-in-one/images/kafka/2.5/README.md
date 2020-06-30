## 准备

1. 创建zkNet的docker网络

``` shell
docker network create --driver bridge --subnet 172.40.0.0/25 --gateway 172.40.0.1  zookeeper_network
```

docker-compose.yml 文件


## 启动Kafka集群

通过下面的命令启动集群，注意是在docker-compose.yml同级目录下

``` shell
docker-compose up -d
```

或者

``` shell
docker-compose -f  docker-compose.yml up -d
```

## Kafka集群测试

下面简单测试一下kafka的命令

1. 进入kafka其中一个容器，通过终端命令创建一个topic并发消息

``` shell
docker exec -it kafka1 /bin/bash
kafka-topics.sh --create --zookeeper zoo1:2181 --replication-factor 1 --partitions 2 --topic test001
```

2. 进入kafka1的终端命令控制台并发几条消息

``` shell
kafka-console-producer.sh --broker-list kafka1:9092 --topic test001
```

3. 通过kafka2开启一个客户端作为consumer接收来自上述kafka1发送的消息

``` shell
kafka-console-consumer.sh --bootstrap-server kafka1:9092 --topic test001 --from-beginning
```
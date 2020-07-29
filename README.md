## env-box
My big data learning environment all in one box based on Docker

基于Docker的Hadoop/Hive/Spark开发测试环境使用说明

## 基本软件环境

软件版本：

- [x] Hadoop 2.7.7
- [x] 操作系统: CentOS 7
- [x] Java环境: JDK 8-251
- [x] Hive 2.3.7
- [x] Hbase 2.2.5 using own zookeeper
- [x] MySQL 5.7.30
- [x] Spark 2.4.6
- [x] Spark 3.0.0
- [ ] Flink 1.10.0
- [x] Zookeeper
- [x] Kafka
- [x] Airflow 1.10.11 集群



基于docker-compose管理镜像和容器，并进行集群的编排



## 镜像依赖关系




## 构建镜像



- 拉取MySQL 5.7 官方镜像

```
docker pull mysql:5.7.30
```

- 拉取CentOS 7 官方镜像

```
docker pull centos:7
```

- 构建所需镜像含CentOS 6和OpenJDK 8

```
docker-compose build
```



在工程根目录下放置了一个docker-compose.yml文件，这一文件中已经预先配置好了由3个slave节点和1个master节点组成的Spark集群。

在使用集群之前，需要先完成初始化



## 初始化集群



```
#[创建容器]
docker-compose up -d
#[初始化Hive数据库。仅在第一次启动集群前执行一次]
docker-compose exec spark-master schematool -dbType mysql -initSchema

#[启动HDFS]
docker-compose exec spark-master start-dfs.sh

#[关闭HDFS]
docker-compose exec spark-master stop-dfs.sh
```



## 启动及停止集群



- 启动集群进程，依次执行：

```
#[启动HDFS]
docker-compose exec spark-master start-dfs.sh
#[启动YARN]
docker-compose exec spark-master start-yarn.sh
#[启动Spark]
docker-compose exec spark-master start-all.sh
```

- 停止Spark集群，依次执行：

```
#[停止Spark]
docker-compose exec spark-master stop-all.sh
#[停止YARN]
docker-compose exec spark-master stop-yarn.sh
#[停止HDFS]
docker-compose exec spark-master stop-dfs.sh
#[停止容器]
docker-compose down
```


## 挂载APP文件夹

在docker-compose编排文件中，挂载本地文件夹到容器中，开发代码直接可以在容器中运行


## 开发与测试过程中的集群使用方法

目前集群中采用的是1个master节点和3个slave节点的分配方案，可以通过调整docker-compose配置文件以及相应软件的配置文件来实现集群扩容，暂时无法做到自动化扩容。

编写程序可以使用任意的IDE和操作系统，程序编写完成后，打包为jar文件，然后放在工程根目录下的./volume/code/目录下。任何一个集群环境下，都会在集群启动时将code目录挂载在master节点的/code路径下。

如果要执行wordcount程序（在volume/code/tests/mapreduce-test目录下已经包含了）。在启动集群并启动各服务进程后。执行下列语句，可以进入master节点的命令行环境：

```
docker-compose exec spark-master /bin/bash
```

然后可以进入/code目录提交任务，完成计算。
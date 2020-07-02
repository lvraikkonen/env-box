## env-box
My big data learning environment all in one box based on Docker

基于Docker的Hadoop开发测试环境使用说明

## 基本软件环境

软件版本：

- [x] Hadoop 2.7.7
- [x] 操作系统: CentOS 7
- [x] Java环境: JDK 8-251
- [x] Hive 2.3.7
- [x] MySQL 5.7.30
- [x] Spark 2.4.6
- [x] Spark 3.0.0
- [ ] Flink 1.10.0
- [x] Zookeeper
- [x] Kafka



j基于docker-compose管理镜像和容器，并进行集群的编排



## 镜像依赖关系



![](https://github.com/ruoyu-chen/hadoop-docker/raw/master/images/arch.jpeg)





## 构建镜像



- 拉取MySQL 5.7 官方镜像

```
docker pull mysql:5.7
```

- 拉取CentOS 6 官方镜像

```
docker pull centos:7
```

- 拉取基本操作系统和OpenJDK环境，包含CentOS 6和OpenJDK 8

```
docker pull twinsen/os-jvm:centos6-openjdk8
```

- 拉取Hadoop环境，包含Hadoop 2.7.2

```
docker pull twinsen/hadoop:2.7.2
```

- 拉取Hive环境，包含Hive 2.1.1

```
docker pull twinsen/hive:2.1.1
```

- 拉取Spark环境，包含Spark 2.1.0

```
docker pull twinsen/spark:2.1.0
```



在工程根目录下放置了一个docker-compose.yml文件，这一文件中已经预先配置好了由3个slave节点和1个master节点组成的Spark集群。

在使用集群之前，需要先完成初始化



## 初始化集群



```
#[创建容器]
docker-compose up -d
#[格式化HDFS。第一次启动集群前，需要先格式化HDFS；以后每次启动集群时，都不需要再次格式化HDFS]
docker-compose exec spark-master hdfs namenode -format
#[初始化Hive数据库。仅在第一次启动集群前执行一次]
docker-compose exec spark-master schematool -dbType mysql -initSchema
#[将Spark相关的jar文件打包，存储在/code目录下，命名为spark-libs.jar]
docker-compose exec spark-master jar cv0f /code/spark-libs.jar -C /root/spark/jars/ .
#[启动HDFS]
docker-compose exec spark-master start-dfs.sh
#[在HDFS中创建/user/spark/share/lib/目录]
docker-compose exec spark-master hadoop fs -mkdir -p /user/spark/share/lib/
#[将/code/spark-libs.jar文件上传至HDFS下的/user/spark/share/lib/目录下]
docker-compose exec spark-master hadoop fs -put /code/spark-libs.jar /user/spark/share/lib/
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



## 开发与测试过程中的集群使用方法

目前集群中采用的是1个master节点和3个slave节点的分配方案，可以通过调整docker-compose配置文件以及相应软件的配置文件来实现集群扩容，暂时无法做到自动化扩容。

编写程序可以使用任意的IDE和操作系统，程序编写完成后，打包为jar文件，然后放在工程根目录下的./volume/code/目录下。任何一个集群环境下，都会在集群启动时将code目录挂载在master节点的/code路径下。

如果要执行wordcount程序（在volume/code/tests/mapreduce-test目录下已经包含了）。在启动集群并启动各服务进程后。执行下列语句，可以进入master节点的命令行环境：

```
docker-compose exec spark-master /bin/bash
```

然后可以进入/code目录提交任务，完成计算。
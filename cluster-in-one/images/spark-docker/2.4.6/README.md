### 使用普通spark集群:

Docker-compose up -d --scale spark-worker=2

启动集群启动后spark master为：spark://localhost:7077

访问spark ui：http://localhost:8080

## build

## 启动Hadoop集群

``` shell
./start-hadoop.sh
```

## 启动Spark集群

``` shell
cd spark
./sbin/start-all.sh
```

## 启动HistoryServer

``` shell
./sbin/start-historyserver.sh
```
## 构建镜像 

``` shell
docker build -t spark:v2.4.5 .
```

## 启动主节点

``` shell
docker run -itd --net=hadoop --name spark-master -p 6066:6066 -p 7077:7077 -p 8081:8080 -h spark-master spark:v2.4.5 ./bin/spark-class org.apache.spark.deploy.master.Master
```

## 启动从节点

``` shell
docker run -itd --net=hadoop --name spark-worker -P -h spark-worker --link spark-master spark:v2.4.5 ./bin/spark-class org.apache.spark.deploy.worker.Worker spark://spark-master:7077
```

## 启动 historyserver 容器

``` shell
docker run -itd --net=hadoop --name spark-history -p 18080:18080 \ 
-e SPARK_HISTORY_OPTS="-Dspark.history.ui.port=18080 \
-Dspark.history.retainedApplications=10 \
-Dspark.history.fs.logDirectory=hdfs://namenode:9000/user/spark/history" \
spark:v2.4.5  spark-class org.apache.spark.deploy.history.HistoryServer
```

## 验证浏览器访问

http://localhost:8081/

启动spark-shell客户端

``` shell
docker exec -it spark-master ./bin/spark-shell
```

![spark-shell](D:\Playground\env-box\spark\spark-shell.PNG)



``` shell
scala> val file = sc.textFile("/usr/local/spark/bin/beeline")
file: org.apache.spark.rdd.RDD[String] = /usr/local/spark/bin/beeline MapPartitionsRDD[1] at textFile at <console>:24

scala> val words = file.flatMap(line => line.split(" ")).map(word => (word,1)).reduceByKey((a,b) => a+b)
words: org.apache.spark.rdd.RDD[(String, Int)] = ShuffledRDD[4] at reduceByKey at <console>:25

scala> words.collect
res0: Array[(String, Int)] = Array(($CLASS,1), (Software,1), (Unless,1), (this,3), (starting,1), (under,4), (The,1), (limitations,1),
("$0")"/find-spark-home,1), (Figure,1), (express,1), (contributor,1), (#,20), (WITHOUT,1), ("AS,1), (#!/usr/bin/env,1), (See,2), (License.,2), 
(for,4), (fi,1), (software,1), (IS",1), (obtain,1), (ANY,1), (SPARK_HOME,1), (out,1), (required,1), (2.0,1), (OR,1), (file,3), (the,9), (-o,1), 
(licenses,1), (not,1), (either,1), (if,2), (posix,2), (source,1), (Apache,2), (then,1), ("License");,1), (language,1), (License,3), (Enter,1),
(permissions,1), (WARRANTIES,1), (license,1), (by,1), (];,1), ("$(dirname,1), (an,1), ([,1), (agreed,1), (Version,1), (implied.,1), (KIND,,1), 
(is,2), ((the,1), (exec,1), ("${SPARK_HOME}",1), (agreements.,1), (on,1), (You,2), (one,1)...
scala> 
```


### 启动容器

``` shell
# start hadoop master container
echo "start hadoop-master container..."

docker run -itd --net=hadoop -p 5070:50070 -p 8088:8088 --name hadoop-master --hostname hadoop-master lvraikkonen/hadoop:2.7.7
```



``` shell
# start hadoop slave container
echo "start hadoop-slave$i container..."
docker run -itd --net=hadoop --name hadoop-slave1 --hostname hadoop-slave1 lvraikkonen/hadoop:2.7.7
docker run -itd --net=hadoop --name hadoop-slave2 --hostname hadoop-slave2 lvraikkonen/hadoop:2.7.7
```


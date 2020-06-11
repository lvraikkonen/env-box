## build

``` shell
docker build -f dockerfile -t flink-service:flink1.10.0 ./
```

## 创建Flink的network

``` shell
docker network create flink
```

## 启动1个job manager和2个task manager

``` shell
docker run -itd  --name flink-jm  -p 8081:8081 -v /home/docker/flink-1.10.0/conf:/flink-1.10.0/conf --network flink flink-service:flink1.10.0 jobmanager
docker run -itd  --name flink-tm  -v /home/docker/flink-1.10.0/conf:/flink-1.10.0/conf --network flink flink-service:flink1.10.0 taskmanager
docker run -itd  --name flink-tm2  -v /home/docker/flink-1.10.0/conf:/flink-1.10.0/conf --network flink flink-service:flink1.10.0 taskmanager
```

## 查看是否存在flink-jm和flink-tm容器

``` shell
[root@k8smaster01 docker]# docker ps
CONTAINER ID        IMAGE                       COMMAND                  CREATED             STATUS              PORTS                                                            NAMES
a80cfceee5f2        flink-service:flink1.10.0   "/home/flink_run.sh …"   4 seconds ago       Up 3 seconds        8088/tcp                                                         flink-tm
305ac1e1d397        flink-service:flink1.10.0   "/home/flink_run.sh …"   20 seconds ago      Up 19 seconds       0.0.0.0:8081->8081/tcp, 8088/tcp                                 flink-jm
729bfc0cd64c        2497f179cf1d                "/usr/sbin/run-vsftp…"   3 months ago        Up 59 minutes       0.0.0.0:20-21->20-21/tcp, 0.0.0.0:21100-21110->21100-21110/tcp   zhaoolee_vsftpd
[root@k8smaster01 docker]#
```

## 外部访问:


http://192.168.108.178:8081/#/overview
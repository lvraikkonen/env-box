## 准备文件

## 创建镜像

``` shell
docker build -t lvraikkonen/mysql57 .
```

## 启动容器

启动容器，并将端口映射到本地的3366端口

``` shell
docker run -d -p 3366:3306 lvraikkonen/mysql57
```

## 验证


上面创建了docker_mysql数据库，并在此数据库中创建了user表，同时将数据库的连接授权赋予了新建的docker用户，因此验证过程为：

使用docker用户登录数据库：mysql -u docker -p
#!/bin/sh
echo '启动mysql'
service mysql start
sleep 5

echo '初始化数据库'
mysql -uroot -p123456 < /mysql/init.sql
echo '初始化完成！'
tail -f /dev/null
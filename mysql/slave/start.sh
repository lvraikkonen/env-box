#!/bin/sh
echo '启动mysql'
service mysql start
sleep 5

tail -f /dev/null
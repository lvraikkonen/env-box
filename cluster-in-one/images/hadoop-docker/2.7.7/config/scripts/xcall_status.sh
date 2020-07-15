#!/bin/bash

for i in hadoop-master hadoop-slave1 hadoop-slave2 hadoop-slave3
do
    echo -------------- $i ------------------
    ssh $i "$* "
done
#!/bin/bash

ZOOKEEPER=`docker ps -a | awk '{print $NF}'  | grep "zookeeper$"`
ZOOKEEPER_RUNNING=$?
if [ $ZOOKEEPER_RUNNING -eq 0 ] ;
then
    echo "Zookeeper is already running"
else
    echo "Starting Zookeeper"
    docker run -p 49181:2181  -h zookeeper --name zookeeper -d jplock/zookeeper
fi

PREFIX=localhost:5000/inventit

# http://www.tech-d.net/2013/12/16/persistent-volumes-with-docker-container-as-volume-pattern/
# Data-only container pattern
docker run -d -i -t --name data \
  -v /var/log \
  ubuntu /bin/sh -c \
  'mkdir -p /var/log/storm; mkdir -p /var/log/supervisor; /bin/sh'
# Must be end with /bin/sh in order to keep the container running

# LogStash with Elastic Search and Kibana
docker run -d \
  --volumes-from data \
  --name logstash \
  -p 514:514 \
  -p 9200:9200 \
  -p 9292:9292 \
  -e LOGSTASH_CONFIG_URL=https://gist.githubusercontent.com/dbaba/c409799a9d1e1703e4d1/raw/logstash.conf \
  pblittle/docker-logstash

# Memcached
docker run -d \
  --name memcached1 \
  tutum/memcached

# Storm Nimbus Node
docker run -d \
  --volumes-from data \
  -p 49773:3773 \
  -p 49772:3772 \
  -p 49627:6627 \
  --name nimbus \
  --link zookeeper:zk \
  -h nimbus \
  $PREFIX/storm-nimbus 

# Storm SV Node
docker run -d \
  --volumes-from data \
  -p 49000:8000 \
  --name supervisor \
  --link nimbus:nimbus \
  --link zookeeper:zk \
  --link memcached1:memcached1 \
  -h supervisor \
  $PREFIX/storm-supervisor

# Storm UI Node
docker run -d \
  --volumes-from data \
  -p 49080:8080 \
  --name ui \
  --link nimbus:nimbus \
  --link zookeeper:zk \
  $PREFIX/storm-ui

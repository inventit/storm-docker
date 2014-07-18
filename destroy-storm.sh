#!/bin/bash

docker kill nimbus; docker rm nimbus
docker kill supervisor; docker rm supervisor
docker kill ui; docker rm ui

docker kill logstash; docker rm logstash
docker kill data; docker rm data
docker kill memcached1; docker rm memcached1

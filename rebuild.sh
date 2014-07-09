#!/bin/bash

PREFIX=localhost:5000/inventit

docker build -t="$PREFIX/storm" storm
docker build -t="$PREFIX/storm-nimbus" storm-nimbus
docker build -t="$PREFIX/storm-supervisor" storm-supervisor
docker build -t="$PREFIX/storm-ui" storm-ui

docker build -t="$PREFIX/data" data

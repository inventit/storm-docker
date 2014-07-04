#!/bin/bash

B2D_PORT=2022
FILE_NAME=storm-docker.tar.gz
ID_FILE_PATH=~/.ssh/id_boot2docker

rm -f $FILE_NAME
cd ..
tar --exclude=.git --exclude=storm-docker/$FILE_NAME --exclude=.-* -z -c -f storm-docker/$FILE_NAME storm-docker
cd storm-docker

scp -i $ID_FILE_PATH -P $B2D_PORT $FILE_NAME docker@localhost:~

ssh -i $ID_FILE_PATH -p $B2D_PORT docker@localhost "tar zxf ~/$FILE_NAME; rm -f $FILE_NAME" 

#!/bin/bash
#!chmod +x ./deploy.sh

if [ "$#" != "1" ]; then
    echo "usage: $0 sit | uat"
    exit 1
fi

BASE_PATH=/Users/mark/work/git/spclod/spcloud
REMOTE_PATH_ROOT=/home/parallels/docker/spcloud
REMOTE_PATH_PJ=$REMOTE_PATH_ROOT/$1
REMOTE_PATH=parallels@10.211.55.5:$REMOTE_PATH_PJ


echo web update
cd $BASE_PATH

if [ "$1" = "eureka-server" ]; then
    echo rm $1 and mkdir $1
    sshpass -p "mxhzmm123!@#" ssh -p 22 parallels@10.211.55.5 "cd $REMOTE_PATH_ROOT ;rm -r -f $1 ; mkdir $1"

    echo send jar
    sshpass -p "mxhzmm123!@#" scp -P 22 $BASE_PATH/eureka-server/target/eureka-server-0.0.1-SNAPSHOT.jar $REMOTE_PATH/eureka-server-0.0.1-SNAPSHOT.jar

    echo send dockerfile
    sshpass -p "mxhzmm123!@#" scp -P 22 $BASE_PATH/eureka-server/Dockerfile $REMOTE_PATH/Dockerfile

    echo delete image
    sshpass -p "mxhzmm123!@#" ssh -p 22 parallels@10.211.55.5 " docker rm -f $(docker ps -f name=$1 -q) "
    sshpass -p "mxhzmm123!@#" ssh -p 22 parallels@10.211.55.5 " docker rmi $1 "

    echo build image
    sshpass -p "mxhzmm123!@#" ssh -p 22 parallels@10.211.55.5 " cd $REMOTE_PATH_PJ ; docker build -t $1:latest . "
    sshpass -p "mxhzmm123!@#" ssh -p 22 parallels@10.211.55.5 " docker run --name $1 -d -p 8761:8761 $1:latest "
fi

echo $1 ok.

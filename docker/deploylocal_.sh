#!/bin/bash
#!chmod +x ./deploylocal.sh

if [ "$#" != "2" ]; then
    echo "usage: $0 name prot"
    exit 1
fi

BASE_PATH=/Users/mark/work/git/spclod/spcloud
BASE_PATH_PJ=/Users/mark/work/git/spclod/spcloud/$1
REMOTE_PATH_ROOT=/home/parallels/docker/spcloud
REMOTE_PATH_PJ=$REMOTE_PATH_ROOT/$1
REMOTE_PATH=parallels@10.211.55.5:$REMOTE_PATH_PJ

PWD=mxhzmm123!@#
USER=parallels
IP=10.211.55.5

echo web update
cd $BASE_PATH

#if [ "$1" = "eureka-server" ]; then

#fi


echo rm $1 and mkdir $1
sshpass -p "mxhzmm123!@#" ssh -p 22 parallels@10.211.55.5 "cd $REMOTE_PATH_ROOT ;rm -r -f $1 ; mkdir $1"

echo send jar
sshpass -p "mxhzmm123!@#" scp -P 22 $BASE_PATH_PJ/target/$1-0.0.1-SNAPSHOT.jar $REMOTE_PATH/$1-0.0.1-SNAPSHOT.jar


echo create Dockerfile
cd $BASE_PATH_PJ
rm Dockerfile
echo FROM java:8-jre >> Dockerfile
echo MAINTAINER mark mark '<115504218@qq.com>' >> Dockerfile
echo ADD $1-0.0.1-SNAPSHOT.jar /app/ >> Dockerfile
echo CMD '["java", "-Xmx200m", "-jar", "/app/$1-0.0.1-SNAPSHOT.jar"]' >> Dockerfile
echo EXPOSE $2 >> Dockerfile


echo send dockerfile
sshpass -p "mxhzmm123!@#" scp -P 22 $BASE_PATH_PJ/Dockerfile $REMOTE_PATH/Dockerfile

echo create redocker.sh
cd $BASE_PATH_PJ
rm redocker.sh
echo docker rm -f '$('docker ps -f name=$1 -q')' >> redocker.sh
echo docker rmi $1 >> redocker.sh
echo docker build -t $1:latest . >> redocker.sh
echo docker run --name $1 -d -p $2:$2 $1:latest >> redocker.sh

echo send redocker.sh
sshpass -p "mxhzmm123!@#" scp -P 22 $BASE_PATH_PJ/redocker.sh $REMOTE_PATH/redocker.sh

echo set promise redocker.sh
sshpass -p "mxhzmm123!@#" ssh -p 22  parallels@10.211.55.5 "cd $REMOTE_PATH_PJ ; chmod +x ./redocker.sh"

echo exec redocker.sh
sshpass -p "mxhzmm123!@#" ssh -p 22  parallels@10.211.55.5 "cd $REMOTE_PATH_PJ ; ./redocker.sh"

echo $1 ok.

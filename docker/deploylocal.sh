#!/bin/bash
#!chmod +x ./deploylocal.sh
#./deploylocal.sh -a eureka-server -b 8761 -c 8761 -d eureka-server
#./deploylocal.sh -a eureka-client -b 8762 -c 8762 -d eureka-client
#./deploylocal.sh -a eureka-client -b 8763 -c 8763 -d eureka-client1
#./deploylocal.sh -a eureka-ribbon -b 8764 -c 8764 -d eureka-ribbon
#./deploylocal.sh -a eureka-feign -b 8765 -c 8765 -d eureka-feign
#./deploylocal.sh -a eureka-client-hystrix -b 8771 -c 8771 -d eureka-client-hystrix
#./deploylocal.sh -a eureka-ribbon-hystrix -b 8766 -c 8766 -d eureka-ribbon-hystrix
#./deploylocal.sh -a eureka-feign-hystrix -b 8767 -c 8767 -d eureka-feign-hystrix
#./deploylocal.sh -a eureka-client-turbine -b 8772 -c 8772 -d eureka-client-turbine

#./deploylocal.sh -a eureka-zuul -b 8768 -c 8768 -d eureka-zuul
#./deploylocal.sh -a eureka-config-server -b 8888 -c 8888 -d eureka-config-server
#./deploylocal.sh -a eureka-config-server -b 8889 -c 8889 -d eureka-config-server1
#./deploylocal.sh -a eureka-config-client -b 8769 -c 8769 -d eureka-config-client
#./deploylocal.sh -a eureka-config-client -b 8770 -c 8770 -d eureka-config-client1
#安装rabbitmq的docker指令 docker run --name rabbitmq-west -d -p 15672:15672 -p 5672:5672 -p 25672:25672 rabbitmq:3-management

#./deploylocal.sh -a eureka-zipkin-server -b 8773 -c 8773 -d eureka-zipkin-server

#高可用注册中心
#./deploylocal.sh -a eureka-server-cluster -b 9999 -c 9999 -d eureka-server-cluster -e --spring.profiles.active=cluster1
#./deploylocal.sh -a eureka-server-cluster -b 9998 -c 9998 -d eureka-server-cluster1 -e --spring.profiles.active=cluster2
#./deploylocal.sh -a eureka-server-cluster -b 9997 -c 9997 -d eureka-server-cluster2 -e --spring.profiles.active=cluster3

#./deploylocal.sh -a eureka-monitor -b 6789 -c 6789 -d eureka-monitor

#./deploylocal.sh -a eureka-security -b 8774 -c 8774 -d eureka-security


echo a:程序的名称
echo b:程序的端口
echo c:映射到docker宿主的端口
echo d:docker相关的名字
echo e:运行jar包的命令行参数

a=程序的名称
b=程序的端口
c=映射到docker宿主的端口
d=docker相关的名字
e=

while getopts "a:,b:,c:,d:,e:" opt; do
  case $opt in
    a)
      echo "this is -a the arg is ! $OPTARG"
      a=$OPTARG
      ;;
    b)
      echo "this is -b the arg is ! $OPTARG"
      b=$OPTARG
      ;;
    c)
      echo "this is -c the arg is ! $OPTARG"
      c=$OPTARG
      ;;
    d)
      echo "this is -d the arg is ! $OPTARG"
      d=$OPTARG
      ;;
    e)
      echo "this is -e the arg is ! $OPTARG"
      e=$OPTARG
      ;;
    \?)
      echo "参数不正确 $OPTARG"
      exit 1
      ;;
  esac
done

BASE_PATH=/Users/mark/work/git/spclod/spcloud
BASE_PATH_PJ=/Users/mark/work/git/spclod/spcloud/$a
REMOTE_PATH_ROOT=/home/parallels/docker/spcloud
REMOTE_PATH_PJ=$REMOTE_PATH_ROOT/$a
REMOTE_PATH=parallels@10.211.55.5:$REMOTE_PATH_PJ



echo web update
cd $BASE_PATH

mvn clean install



echo rm $a and mkdir $a
sshpass -p "mxhzmm123!@#" ssh -p 22 parallels@10.211.55.5 "cd $REMOTE_PATH_ROOT ;rm -r -f $a ; mkdir $a"

echo send jar
sshpass -p "mxhzmm123!@#" scp -P 22 $BASE_PATH_PJ/target/$a-0.0.1-SNAPSHOT.jar $REMOTE_PATH/$a-0.0.1-SNAPSHOT.jar


echo create Dockerfile
cd $BASE_PATH_PJ
rm Dockerfile
echo FROM java:8-jre >> Dockerfile
echo MAINTAINER mark mark '<115504218@qq.com>' >> Dockerfile
echo ADD $a-0.0.1-SNAPSHOT.jar /app/ >> Dockerfile
#echo 'RUN /bin/echo -e "export SERVER_PORT='$b'" >> /etc/profile' >> Dockerfile
#echo CMD '["java", "-Xmx200m", "-jar", "/app/'$a'-0.0.1-SNAPSHOT.jar","--server.port='$b' ' $e'"]' >> Dockerfile
echo CMD java -Xmx200m -jar /app/$a-0.0.1-SNAPSHOT.jar --server.port=$b $e >> Dockerfile
echo EXPOSE $b >> Dockerfile


echo send dockerfile
sshpass -p "mxhzmm123!@#" scp -P 22 $BASE_PATH_PJ/Dockerfile $REMOTE_PATH/Dockerfile

echo create redocker.sh
cd $BASE_PATH_PJ
rm redocker.sh
echo docker rm -f '$('docker ps -a -f name=$d -q')' >> redocker.sh
echo docker rmi $d >> redocker.sh
echo docker build -t $d:latest . >> redocker.sh
echo docker run --name $d -d -p $c:$b $d:latest >> redocker.sh

echo send redocker.sh
sshpass -p "mxhzmm123!@#" scp -P 22 $BASE_PATH_PJ/redocker.sh $REMOTE_PATH/redocker.sh

echo set promise redocker.sh
sshpass -p "mxhzmm123!@#" ssh -p 22  parallels@10.211.55.5 "cd $REMOTE_PATH_PJ ; chmod +x ./redocker.sh"

echo exec redocker.sh
sshpass -p "mxhzmm123!@#" ssh -p 22  parallels@10.211.55.5 "cd $REMOTE_PATH_PJ ; ./redocker.sh"

echo $a ok.

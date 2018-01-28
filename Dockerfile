FROM java:8-jre
MAINTAINER mark mark <115504218@qq.com>
ADD 程序的名称-0.0.1-SNAPSHOT.jar /app/
CMD java -Xmx200m -jar /app/程序的名称-0.0.1-SNAPSHOT.jar --server.port=程序的端口
EXPOSE 程序的端口

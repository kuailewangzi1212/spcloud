FROM java:8-jre
MAINTAINER mark mark <115504218@qq.com>
ADD eureka-server-cluster-0.0.1-SNAPSHOT.jar /app/
CMD java -Xmx200m -jar /app/eureka-server-cluster-0.0.1-SNAPSHOT.jar --server.port=9997 --spring.profiles.active=cluster3
EXPOSE 9997

FROM java:8-jre
MAINTAINER mark mark <115504218@qq.com>
ADD eureka-feign-hystrix-0.0.1-SNAPSHOT.jar /app/
CMD ["java", "-Xmx200m", "-jar", "/app/eureka-feign-hystrix-0.0.1-SNAPSHOT.jar","--server.port=8767"]
EXPOSE 8767

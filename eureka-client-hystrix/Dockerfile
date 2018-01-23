FROM java:8-jre
MAINTAINER mark mark <115504218@qq.com>
ADD eureka-client-hystrix-0.0.1-SNAPSHOT.jar /app/
CMD ["java", "-Xmx200m", "-jar", "/app/eureka-client-hystrix-0.0.1-SNAPSHOT.jar","--server.port=8771"]
EXPOSE 8771

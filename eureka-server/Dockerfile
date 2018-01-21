FROM java:8-jre
MAINTAINER mark mark <115504218@qq.com>
ADD eureka-server-0.0.1-SNAPSHOT.jar /app/
RUN /bin/echo -e "export SERVER_PORT=8761" >> /etc/profile
CMD ["java", "-Xmx200m", "-jar", "/app/eureka-server-0.0.1-SNAPSHOT.jar"]
EXPOSE 8761

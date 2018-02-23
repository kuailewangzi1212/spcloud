docker rm -f $(docker ps -a -f name=eureka-security -q)
docker rmi eureka-security
docker build -t eureka-security:latest .
docker run --name eureka-security -d -p 8774:8774 eureka-security:latest

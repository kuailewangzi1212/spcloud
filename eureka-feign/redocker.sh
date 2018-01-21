docker rm -f $(docker ps -a -f name=eureka-feign -q)
docker rmi eureka-feign
docker build -t eureka-feign:latest .
docker run --name eureka-feign -d -p 8765:8765 eureka-feign:latest

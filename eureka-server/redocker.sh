docker rm -f $(docker ps -a -f name=eureka-server -q)
docker rmi eureka-server
docker build -t eureka-server:latest .
docker run --name eureka-server -d -p 8761:8761 eureka-server:latest

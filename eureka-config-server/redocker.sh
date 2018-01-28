docker rm -f $(docker ps -a -f name=eureka-config-server -q)
docker rmi eureka-config-server
docker build -t eureka-config-server:latest .
docker run --name eureka-config-server -d -p 8888:8888 eureka-config-server:latest

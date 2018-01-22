docker rm -f $(docker ps -a -f name=eureka-config-server1 -q)
docker rmi eureka-config-server1
docker build -t eureka-config-server1:latest .
docker run --name eureka-config-server1 -d -p 8889:8889 eureka-config-server1:latest

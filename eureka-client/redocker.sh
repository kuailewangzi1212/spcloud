docker rm -f $(docker ps -a -f name=eureka-client1 -q)
docker rmi eureka-client1
docker build -t eureka-client1:latest .
docker run --name eureka-client1 -d -p 8763:8763 eureka-client1:latest

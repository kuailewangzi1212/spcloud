docker rm -f $(docker ps -a -f name=eureka-config-client1 -q)
docker rmi eureka-config-client1
docker build -t eureka-config-client1:latest .
docker run --name eureka-config-client1 -d -p 8770:8770 eureka-config-client1:latest

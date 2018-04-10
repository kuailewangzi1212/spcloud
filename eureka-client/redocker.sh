docker rm -f $(docker ps -a -f name=eureka-client -q)
docker rmi eureka-client
docker build -t eureka-client:latest .
docker run --name eureka-client -d -p 8762:8762 eureka-client:latest

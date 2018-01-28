docker rm -f $(docker ps -a -f name=eureka-config-client -q)
docker rmi eureka-config-client
docker build -t eureka-config-client:latest .
docker run --name eureka-config-client -d -p 8769:8769 eureka-config-client:latest

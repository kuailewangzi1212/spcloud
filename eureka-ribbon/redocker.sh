docker rm -f $(docker ps -a -f name=eureka-ribbon -q)
docker rmi eureka-ribbon
docker build -t eureka-ribbon:latest .
docker run --name eureka-ribbon -d -p 8764:8764 eureka-ribbon:latest

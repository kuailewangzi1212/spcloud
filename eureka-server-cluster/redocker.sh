docker rm -f $(docker ps -a -f name=eureka-server-cluster2 -q)
docker rmi eureka-server-cluster2
docker build -t eureka-server-cluster2:latest .
docker run --name eureka-server-cluster2 -d -p 9997:9997 eureka-server-cluster2:latest

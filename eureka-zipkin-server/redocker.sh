docker rm -f $(docker ps -a -f name=eureka-zipkin-server -q)
docker rmi eureka-zipkin-server
docker build -t eureka-zipkin-server:latest .
docker run --name eureka-zipkin-server -d -p 8773:8773 eureka-zipkin-server:latest

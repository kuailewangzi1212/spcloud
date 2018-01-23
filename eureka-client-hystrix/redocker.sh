docker rm -f $(docker ps -a -f name=eureka-client-hystrix -q)
docker rmi eureka-client-hystrix
docker build -t eureka-client-hystrix:latest .
docker run --name eureka-client-hystrix -d -p 8771:8771 eureka-client-hystrix:latest

docker rm -f $(docker ps -a -f name=eureka-feign-hystrix -q)
docker rmi eureka-feign-hystrix
docker build -t eureka-feign-hystrix:latest .
docker run --name eureka-feign-hystrix -d -p 8767:8767 eureka-feign-hystrix:latest

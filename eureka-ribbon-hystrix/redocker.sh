docker rm -f $(docker ps -a -f name=eureka-ribbon-hystrix -q)
docker rmi eureka-ribbon-hystrix
docker build -t eureka-ribbon-hystrix:latest .
docker run --name eureka-ribbon-hystrix -d -p 8766:8766 eureka-ribbon-hystrix:latest

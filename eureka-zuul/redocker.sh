docker rm -f $(docker ps -a -f name=eureka-zuul -q)
docker rmi eureka-zuul
docker build -t eureka-zuul:latest .
docker run --name eureka-zuul -d -p 8768:8768 eureka-zuul:latest

docker rm -f $(docker ps -a -f name=eureka-client-webservice -q)
docker rmi eureka-client-webservice
docker build -t eureka-client-webservice:latest .
docker run --name eureka-client-webservice -d -p 8775:8775 eureka-client-webservice:latest

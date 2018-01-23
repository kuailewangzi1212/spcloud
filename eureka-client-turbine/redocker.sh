docker rm -f $(docker ps -a -f name=eureka-client-turbine -q)
docker rmi eureka-client-turbine
docker build -t eureka-client-turbine:latest .
docker run --name eureka-client-turbine -d -p 8772:8772 eureka-client-turbine:latest

docker rm -f $(docker ps -a -f name=eureka-monitor -q)
docker rmi eureka-monitor
docker build -t eureka-monitor:latest .
docker run --name eureka-monitor -d -p 6789:6789 eureka-monitor:latest

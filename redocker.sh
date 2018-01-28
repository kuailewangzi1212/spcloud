docker rm -f $(docker ps -a -f name=docker相关的名字 -q)
docker rmi docker相关的名字
docker build -t docker相关的名字:latest .
docker run --name docker相关的名字 -d -p 映射到docker宿主的端口:程序的端口 docker相关的名字:latest

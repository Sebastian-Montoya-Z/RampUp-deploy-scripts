#!/usr/bin/env bash
docker network create -d bridge mynetwork
sudo docker build ../../../RampUp_frontend/nginx -t nginx --no-cache
sudo docker build ../../../RampUp_frontend/frontend -t web --no-cache
sudo docker build ../../../RampUp_login/auth-api -t auth --no-cache
sudo docker build ../../../RampUp_login/users-api -t users --no-cache
sudo docker build ../../../RampUp_TODO/todos-api -t todos --no-cache
sudo docker build ../../../RampUp_TODO/redis -t redis--no-cache 
sudo docker build ../../../RampUp_TODO/log-message-processor -t log --no-cache
sudo docker build ../../../RampUp_TODO/zipkin -t zipkin --no-cache
sudo docker run --name zipkin -d --network mynetwork -p 9411:9411 zipkin 
sleep 1
sudo docker run --name users -d --network mynetwork -p 8083:8083 -e SPRING_ZIPKIN_BASE_URL=http://zipkin:9411 -e SERVER_PORT=8083 -e JWT_SECRET=PRFT users
sleep 1
sudo docker run --name auth -d --network mynetwork -p 8000:8000 -e ZIPKIN_URL=http://zipkin:9411/api/v2/spans -e AUTH_API_PORT=8081 -e JWT_SECRET=PRFT -e USERS_API_ADDRESS=http://users:8083 auth
sleep 1
sudo docker run --name redis -d --network mynetwork -p 6379:6379 redis
sleep 1
sudo docker run --name todos -d --network mynetwork -p 8082:8082 -e ZIPKIN_URL=http://zipkin:9411/api/v2/spans -e TODO_API_PORT=8082 -e JWT_SECRET=PRFT -e REDIS_HOST=redis -e REDIS_PORT=6379 -e REDIS_CHANNEL=log_channel todos
sleep 1
sudo docker run --name log -d --network mynetwork -e REDIS_HOST=redis -e REDIS_PORT=6379 -e REDIS_CHANNEL=log_channel -e ZIPKIN_URL=http://zipkin:9411/api/v2/spans log
sleep 1
sudo docker run --name web -d --network mynetwork -p 8080:8080 -e ZIPKIN_URL=http://zipkin:9411/api/v2/spans -e PORT=8080 -e AUTH_API_ADDRESS=http://auth:8081 -e TODOS_API_ADDRESS=http://todos:8082 web
sleep 1
sudo docker run --name nginx -d --network mynetwork -p 8009:8009 nginx
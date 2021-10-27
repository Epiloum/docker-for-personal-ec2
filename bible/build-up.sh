#!/bin/bash

# swarm mode off
echo "---------------------------"
echo "      Docker Swarm Off"
echo "==========================="
docker swarm leave -f

# docker compose build
echo "---------------------------"
echo "   Docker-compose Build"
echo "==========================="
sleep 3
docker image prune -f
sleep 3
docker-compose build --no-cache

# swarm mode on
echo "---------------------------"
echo "      Docker Swarm On"
echo "==========================="
sleep 3
docker swarm init

# deploy by temporary configuration file
echo "---------------------------"
echo "    Docker Stack Deploy"
echo "==========================="
sleep 3
docker-compose -f docker-compose.yml config > docker-compose-out.yml
docker stack deploy -c docker-compose-out.yml bible
rm docker-compose-out.yml

# composer install
echo "---------------------------"
echo "     Composer Install"
echo "==========================="
sleep 3
docker exec $(docker ps -aqf "name=app_dev") composer install
docker exec $(docker ps -aqf "name=app_dev") chmod -R +x /var/www/vendor
docker exec $(docker ps -aqf "name=app_dev") chmod -R 777 /var/www/storage

docker exec $(docker ps -aqf "name=app_prod") composer install
docker exec $(docker ps -aqf "name=app_prod") chmod -R +x /var/www/vendor
docker exec $(docker ps -aqf "name=app_prod") chmod -R 777 /var/www/storage

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
docker image prune -f
docker system prune -f
docker-compose pull
docker-compose build --no-cache

# swarm mode on
echo "---------------------------"
echo "      Docker Swarm On"
echo "==========================="
docker swarm init

# deploy by temporary configuration file
echo "---------------------------"
echo "    Docker Stack Deploy"
echo "==========================="
docker-compose -f docker-compose.yml config > docker-compose-out.yml
docker stack deploy -c docker-compose-out.yml epiloum
rm docker-compose-out.yml

# composer install
echo "---------------------------"
echo "     Composer Install"
echo "==========================="
sleep 3
docker exec $(docker ps -aqf "name=bible_dev_php") composer install
docker exec $(docker ps -aqf "name=bible_dev_php") chmod -R +x /var/www/vendor
docker exec $(docker ps -aqf "name=bible_dev_php") chmod -R 777 /var/www/storage

docker exec $(docker ps -aqf "name=bible_prod_php") composer install
docker exec $(docker ps -aqf "name=bible_prod_php") chmod -R +x /var/www/vendor
docker exec $(docker ps -aqf "name=bible_prod_php") chmod -R 777 /var/www/storage

#!/bin/bash

# build
docker-compose build --no-cache
sleep 3

# deploy by temporary configuration file
docker-compose config -f docker-compose.yml > docker-compose-out.yml
docker stack deploy -c docker-compose-out.yml bible
rm docker-compose-out.yml
sleep 3

# up
docker-compose up -d
sleep 3

# composer install
docker exec $(docker ps -aqf "name=app_dev") composer install
docker exec $(docker ps -aqf "name=app_dev") chmod -R +x /var/www/vendor
docker exec $(docker ps -aqf "name=app_prod") composer install
docker exec $(docker ps -aqf "name=app_prod") chmod -R +x /var/www/vendor

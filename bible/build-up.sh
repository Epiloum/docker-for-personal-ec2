#!/bin/bash

# build
docker-compose build --no-cache

# deploy by temporary configuration file
docker-compose config -f docker-compose.yml > docker-compose-out.yml
docker stack deploy -c docker-compose-out.yml bible
rm docker-compose-out.yml

# up
docker-compose up -d

# composer install
docker exec $(docker ps -aqf "name=app_dev") composer install
docker exec $(docker ps -aqf "name=app_prod") composer install

#!/bin/bash

# build
echo "---------------------------"
echo "   Docker-compose Build"
echo "==========================="
docker-compose build --no-cache

# deploy by temporary configuration file
echo "---------------------------"
echo "    Docker Stack Deploy"
echo "==========================="
sleep 3
docker-compose -f docker-compose.yml config > docker-compose-out.yml
docker stack deploy -c docker-compose-out.yml bible
rm docker-compose-out.yml

# up
echo "---------------------------"
echo "     Docker-compose Up"
echo "==========================="
sleep 3
docker-compose up -d

# composer install
echo "---------------------------"
echo "     Composer Install"
echo "==========================="
sleep 3
docker exec $(docker ps -aqf "name=app_dev") composer install
docker exec $(docker ps -aqf "name=app_dev") chmod -R +x /var/www/vendor
docker exec $(docker ps -aqf "name=app_dev") chmod -R 777 /var/www/storage
docker exec $(docker ps -aqf "name=app_dev") php artisan key:generate
docker exec $(docker ps -aqf "name=app_dev") php artisan passport:keys
docker exec $(docker ps -aqf "name=app_dev") php artisan storage:link

docker exec $(docker ps -aqf "name=app_prod") composer install
docker exec $(docker ps -aqf "name=app_prod") chmod -R +x /var/www/vendor
docker exec $(docker ps -aqf "name=app_prod") chmod -R 777 /var/www/storage
docker exec $(docker ps -aqf "name=app_prod") php artisan key:generate
docker exec $(docker ps -aqf "name=app_prod") php artisan passport:keys
docker exec $(docker ps -aqf "name=app_prod") php artisan storage:link




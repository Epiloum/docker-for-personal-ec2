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

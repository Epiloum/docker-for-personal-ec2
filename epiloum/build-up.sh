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
docker stack deploy -c docker-compose-out.yml epiloum
rm docker-compose-out.yml

docker-compose build --no-cache
docker-compose config -f docker-compose.yml > docker-compose-out.yml
docker stack deploy -c docker-compose-out.yml bible
rm docker-compose-out.yml
docker-compose up -d
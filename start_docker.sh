#!/bin/bash

docker-compose up -d
sleep 0.5
docker ps -a
echo " - docker logs"
docker logs my_alpine
# --- END --- #

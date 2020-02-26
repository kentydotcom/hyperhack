#!/bin/bash

#  Dr Kent G Lau
#  kenty@kenty.com

#  Hyperhack 2020

# Exit on first error, print all commands.
set -e

# Shut down the Docker containers for the system tests.
docker-compose -f docker-compose.yml kill && docker-compose -f docker-compose.yml down

# remove the local state
rm -f ~/.hfc-key-store/*

# remove chaincode docker images
docker system prune -f
docker volume prune -f

docker rm $(docker ps -aq)
docker rmi $(docker images dev-* -q)
# Your system is now clean

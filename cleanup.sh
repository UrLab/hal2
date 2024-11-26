#!/bin/sh
echo "Trying to erase current running docker"
if [$# -le 1]; 
    then echo "No folder given. Aborting..."
    exit
fi
docker-compose down
sudo rm -rf $@
docker image prune -a -f
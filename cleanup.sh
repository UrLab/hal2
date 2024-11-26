#!/bin/bash
echo "Trying to erase current running docker"
if [$# -le 1]; then 
    echo "Usage: $0 <folder_name> [folder_name ...]"
    exit
fi
docker-compose down
sudo rm -rf $@
docker image prune -a -f

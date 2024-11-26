#!/bin/bash
#MQTT Broker

git clone https://github.com/urlab/mqtt-broker.git $HOME/mqtt-broker/
cd $HOME/mqtt-broker/
docker-compose up -d


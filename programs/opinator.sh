#!/bin/bash
#Opinator Triggers

git clone https://github.com/urlab/opinator.git $HOME/opinator/
cd $HOME/opinator/software/

echo "Need entries for .env opinator triggers"
echo "For the Api Key, nothing will be written in terminal"
read -r -s -p "Enter opinator API Key: " ApiKey
echo "API_KEY=$ApiKey" >> .env
unset ApiKey

read -r -p "Enter opinator Server URL : " ServerUrl
echo "SERVER_URL=$ServerUrl" >> .env
unset ServerUrl

read -r -p "Enter opinator WebHook URL : " WebHookUrl
echo "WEBHOOK_URL=$WebHookUrl" >> .env
unset WebHookUrl

read -r -p "Enter opinator MQTT Broker Ip : " MqttBrokerUrl
echo "MQTT_HOST=$MqttBrokerUrl" >> .env
unset MqttBrokerUrl

read -r -p "Enter opinator MQTT Topic : " MqttTopic
echo "OPINATOR_TOPIC=$MqttTopic" >> .env
unset MqttTopic

docker-compose up -d


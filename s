#!/bin/bash

options=(
  "0) All [default]"
  "1) MQTT-broker"
  "2) MQTT-Opinator"
  "3) Musicman"
  "4) UrStib"
  "5) Home-Assistant"
  "6) UrMainPage"
)

echo "Please select an option:"
for option in "${options[@]}"; do
  echo "$option"
done

read -p "Enter the number of your choice: " choice

if [ -z "$choice" ]; then
	choice=7
fi

case $choice in
  1) echo "You selected MQTT-broker";;
  2) echo "You selected MQTT-Opinator";;
  3) echo "You selected Musicman";;
  4) echo "You selected UrStib";;
  5) echo "You selected Home-Assistant";;
  6) echo "You selected UrMainPage";;
  7) echo "You selected All [default]";;
  *) echo "Invalid option. Please try again.";;
esac


#!/bin/bash

DEVMODE=0

if [ "$EUID" -ne 0 ]; then
	echo "Please run script with sudo."
	exit 1
fi

separator() {
    echo "$(printf '%.0s-' {1..40})"
}


separator
echo "Update and needed packages installation..."
separator
sudo apt update
sudo apt install git apache2-utils -y

separator
echo "Raspifresh installation..."
separator
read -p "Run Raspifresh installation ? (see https://github.com/urlab/raspifresh) [y/N]: " -n 1 -r reply
if [[ $reply =~ ^[Yy]$ ]]; then
	echo
	echo "Executing Raspifresh..."
	git clone https://github.com/urlab/raspifresh.git
	cd raspifresh
	./fresh.sh y
	cd ..
	rm -rf raspifresh
fi

separator
echo "Hal2 configuration..."
separator
DO_CONFIG=1
if [ -f .env ];then
	read -p "Found a .env file ! Do you want to override it with a new configuration ? [y/N]: " -n 1 -r reply
	if [[ $reply =~ ^[Yy]$ ]]; then
		echo "Deleting .env..."
		rm .env
	else
		DO_CONFIG=0
	fi
fi

if [[ $DO_CONFIG -eq 1 ]]; then
	touch .env
	echo "Please enter the admin password of the container : "
	htpasswd -B .env HASH_ADMIN
	# Portainer want to double all $ and we need to put a = instead of a : in the .env file AND to put two single quotes so bash do not try to interpret the password.
	sed -E -i "s/:/='/; s/$/'/; s/\\$/\\$\\$/g" .env
fi

separator
echo "Programs selection..."
separator
programs=($(ls ./programs/ | grep "\.sh"))

# Descriptor is commented in the second line of the file
declare -a programs_descriptors
for ((i = 0; i < ${#programs[@]}; i++)); do
	programs_descriptors+=("$(sed '2q;d' ./programs/${programs[$i]} | sed 's/^.//')")
done

echo "Programs available to installation : "
for ((i = 0; i < ${#programs_descriptors[@]}; i++)); do
        echo "$i) ${programs_descriptors[$i]}"
done

read -p "Enter program numbers to install (separated by space) [0]: " -r programs_to_install
if [ -z "$programs_to_install" ]; then
	programs_to_install=0
fi

if [[ $programs_to_install =~ [^0-9\ ] ]]; then
	echo "Invalid input. Exiting..."
	exit 1
fi

if [[ $DEVMODE -eq 1 ]]; then
	echo "Exiting because dev mode is on."
	exit 0
fi


separator
echo "Portainer installation..."
separator
sudo apt install -y curl docker.io
sudo curl -SL https://github.com/docker/compose/releases/download/v2.30.1/docker-compose-linux-armv7 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
#sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo usermod -aG docker $SUDO_USER

separator
echo "Portainer installation successful."
echo "Starting portainer..."
separator
#if [[ -n "$SUDO_USER" ]]; then
#	su - $SUDO_USER -c "newgrp docker"
#fi
docker-compose up -d

if [[ $programs_to_install =~ "0" ]]; then
	for ((i = 0; i < ${#programs[@]}; i++)); do
		separator
		echo "Installing ${programs_descriptors[$i]}..."
		separator
		./programs/${programs[$i]}
	done
else
	for i in $programs_to_install; do
		separator
		echo "Installing ${programs_descriptors[$i]}..."
		separator
		./programs/${programs[$i]}
	done
fi


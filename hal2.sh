#!/bin/bash

DEVMODE=0

if [ "$EUID" -ne 0 ]; then
	echo "Please run script with sudo."
	exit 1
fi

programs=($(ls ./programs/ | cut -d'.' -f 1))

# Descriptor is commented in the second line of the file
declare -A programs_descriptors
for ((i = 0; i < ${#programs[@]}; i++)); do
	programs_descriptors[${programs[$i]}]=$(sed '2q;d' ./programs/${programs[$i]}.sh | sed 's/^.//')

done

if [ ${#programs[@]} -ne ${#programs_descriptors[@]}  ]; then
	echo "Error : Number of programs do not match number of programs descriptors."
	echo "Installation script is misconfigured. Exiting..."
	exit 1
fi


echo "Programs available to installation : "
for ((i = 0; i < ${#programs_descriptors[@]}; i++)); do
        echo "$i) ${programs_descriptors[${programs[$i]}]}"
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

sudo apt update && sudo apt full-upgrade
sudo apt install vim git python3
sudo ln -s /bin/vim /bin/v
sudo apt purge nano
sudo ln -s /bin/vim /bin/nano

git clone https://github.com/urlab/config-files.git
cp config-files/.vimrc ~/.vimrc
cp config-files/.bashrc ~/.bashrc
cp config-files/.bash_aliases ~/.bash_aliases
rm -rf config-files

if [[ $programs_to_install =~ "0" ]]; then
	for ((i = 0; i < ${#programs[@]}; i++)); do
		echo "Installing ${programs_descriptors[${programs[$i]}]}..."
		./programs/${programs[$i]}.sh
	done
else
	for program in $programs_to_install; do
		echo "Installing ${programs_descriptors[${programs[$program]}]}..."
		./programs/${programs[$program]}.sh
	done
fi


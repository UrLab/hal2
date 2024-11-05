#!/bin/bash

DEVMODE=0

if [ "$EUID" -ne 0 ]; then
	echo "Please run script with sudo."
	exit 1
fi

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

if [[ $programs_to_install =~ "0" ]]; then
	for ((i = 0; i < ${#programs[@]}; i++)); do
		echo "Installing ${programs_descriptors[$i]}..."
		./programs/${programs[$i]}
	done
else
	for i in $programs_to_install; do
		echo "Installing ${programs_descriptors[$i]}..."
		./programs/${programs[$i]}
	done
fi


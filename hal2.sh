#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "Please run script with sudo."
	exit 1
fi

sudo apt install vim git 
sudo ln -s /bin/vim /bin/v
sudo apt purge nano
sudo ln -s /bin/vim /bin/nano

git clone https://github.com/urlab/config-files.git
cp config-files/.vimrc ~/.vimrc
cp config-files/.bashrc ~/.bashrc
cp config-files/.bash_aliases ~/.bash_aliases
rm -rf config-files

sudo apt update && sudo apt full-upgrade




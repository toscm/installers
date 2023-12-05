#!/bin/bash

# Check if username is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 username"
    exit 1
fi

username=$1
scriptdir=$(dirname "$0")

sudo useradd --create-home $username
sudo passwd  $username
sudo usermod --shell /bin/bash $username
sudo mkdir /home/$username/.ssh
sudo cp $scriptdir/authorized_keys /home/$username/.ssh/
sudo chown -R $username:$username /home/$username/.ssh
sudo chmod 700 /home/$username/.ssh
sudo chmod 600 /home/$username/.ssh/authorized_keys

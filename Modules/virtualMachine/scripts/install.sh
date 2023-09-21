#! /bin/bash

sudo apt-get update -y

sudo apt-get upgrade -y

sleep 10

echo "Installing Azure CLI......"

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash 

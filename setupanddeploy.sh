#!/bin/bash


echo "Updating package lists..."
sudo apt-get update


echo "Installing nginx..."
sudo apt-get install -y nginx


echo "Enabling UFW firewall..."
sudo ufw enable


echo "Configuring UFW firewall..."
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw status


echo "Installing Docker..."
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce


echo "Copying default.conf to /etc/nginx/sites-available/default..."
sudo cp $(dirname "$0")/nginx/default.conf /etc/nginx/sites-available/default


echo "Restarting nginx..."
sudo systemctl restart nginx


echo "Building Docker image..."
sudo docker build --build-arg PORT=9000 -t proxyapp .


echo "Running Docker container..."
sudo docker run -d -p 9000:9000 --name proxyapp_container proxyapp

echo "All tasks completed successfully!"

#!/bin/bash

# Update package list
sudo apt update -y

# Install Nginx
sudo apt install nginx -y

# Enable & start nginx service
sudo systemctl enable nginx
sudo systemctl start nginx

# Custom homepage
echo "<h1>Nginx Installed Successfully on $(hostname)</h1>" | sudo tee /var/www/html/index.html

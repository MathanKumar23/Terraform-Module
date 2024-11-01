#!/bin/bash
sudo apt update
sudo apt install nginx -y
sudo apt install git -y
sudo git clone https://github.com/MathanKumar23/HtmlPage
sudo rm -rf /var/www/html/index.nginx-debian.html
sudo cp HtmlPage/index.html /var/www/html/index.html
echo "<h1>${var.environment}-public-Server-${count.index + 1}</h1>" >> /var/www/html/index.html
sudo systemctl start nginx
sudo systemctl enable nginx
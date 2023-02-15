#!/usr/bin/env bash
sudo chmod 744 upgrade.sh
sudo ./upgrade.sh

cd /home/vagrant 

git clone https://github.com/Sebastian-Montoya-Z/RampUp_frontend

sudo chmod 744 node_install.sh 
sudo ./node_install.sh
cd /home/vagrant/RampUp_frontend/frontend
npm install
npm run build

sudo cp /home/vagrant/RampUp_frontend/frontend/scripts/RampUp-frontend.service /lib/systemd/system/RampUp-frontend.service
sudo systemctl daemon-reload
sudo systemctl enable RampUp-frontend
sudo systemctl start RampUp-frontend

sudo apt-get -y install nginx
sudo unlink /etc/nginx/sites-available/default
sudo cp /home/vagrant/RampUp_frontend/frontend/scripts/nginx/myserver.config /etc/nginx/sites-available/myserver.config
sudo ln -sf /etc/nginx/sites-available/myserver.config /etc/nginx/sites-enabled/
sudo rm -rf /etc/nginx/sites-enabled/default
sudo rm -rf /etc/nginx/sites-available/default

sudo systemctl restart nginx
sudo ufw allow 'Nginx Full'
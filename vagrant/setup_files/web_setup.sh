#!/usr/bin/env bash
sudo apt-get update -y

cd /home/vagrant 

git clone https://github.com/Sebastian-Montoya-Z/RampUp_frontend

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source .bashrc
source ~/.nvm/nvm.sh
echo "source ~/.nvm/nvm.sh" >> ~/.bashrc
nvm install v8.17.0
nvm use v8.17.0
sudo rm -f /usr/bin/node
sudo rm -f /usr/bin/npm
sudo ln -sf $(which node) /usr/bin/
sudo ln -sf $(which npm) /usr/bin/

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
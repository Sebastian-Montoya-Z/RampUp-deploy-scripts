#!/usr/bin/env bash
sudo chmod 744 upgrade.sh
sudo ./upgrade.sh

cd /home/vagrant 

git clone https://github.com/Sebastian-Montoya-Z/RampUp_TODO

curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
sudo apt-get update -y
sudo apt-get install redis -y
sudo systemctl daemon-reload

sudo systemctl enable redis-server
sudo systemctl start redis-server

cd /home/vagrant/RampUp_TODO/log-message-processor
sudo apt install python3-pip -y
pip3 install -r requirements.txt

cd /home/vagrant

sudo chmod 744 node_install.sh 
sudo ./node_install.sh

cd /home/vagrant/RampUp_TODO/todos-api/
npm install

sudo cp /home/vagrant/RampUp_TODO/log-message-processor/scripts/RampUp-log-message-processor.service /lib/systemd/system/RampUp-log-message-processor.service
sudo cp /home/vagrant/RampUp_TODO/todos-api/scripts/RampUp-todos-api.service /lib/systemd/system/RampUp-todos-api.service

sudo systemctl daemon-reload
sudo systemctl enable RampUp-log-message-processor
sudo systemctl enable RampUp-todos-api
sudo systemctl start RampUp-log-message-processor
sudo systemctl start RampUp-todos-api



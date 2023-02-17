#!/usr/bin/env bash
sudo apt-get update -y

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

cd /home/vagrant/RampUp_TODO/todos-api/
npm install

sudo cp /home/vagrant/RampUp_TODO/log-message-processor/scripts/RampUp-log-message-processor.service /lib/systemd/system/RampUp-log-message-processor.service
sudo cp /home/vagrant/RampUp_TODO/todos-api/scripts/RampUp-todos-api.service /lib/systemd/system/RampUp-todos-api.service

sudo systemctl daemon-reload
sudo systemctl enable RampUp-log-message-processor
sudo systemctl enable RampUp-todos-api
sudo systemctl start RampUp-log-message-processor
sudo systemctl start RampUp-todos-api



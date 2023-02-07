#!/usr/bin/env bash
sudo apt-get update && apt upgrade -y

cd /home/vagrant 

git clone https://github.com/Sebastian-Montoya-Z/RampUp_login

cd /home/vagrant/RampUp_login/auth-api
sudo curl -LO https://go.dev/dl/go1.18.2.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.18.2.linux-amd64.tar.gz
export GOROOT=/usr/local/go
echo "export GOROOT=/usr/local/go" > /home/vagrant/.profile
export GOPATH=$HOME/go
echo "export GOPATH=$HOME/go" > /home/vagrant/.profile
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
echo "export PATH=$GOPATH/bin:$GOROOT/bin:$PATH" > /home/vagrant/.profile
export PATH=$PATH:/usr/local/go/bin
echo "export PATH=$PATH:/usr/local/go/bin" > /home/vagrant/.profile
source ~/.bashrc

export GO111MODULE=on
echo "export GO111MODULE=on" > /home/vagrant/.profile
go mod init github.com/Sebastian-Montoya-Z/RampUp_login/tree/Development/auth-api
go mod tidy
go build

sudo apt-get install openjdk-8-jdk -y

cd /home/vagrant/RampUp_login/users-api
./mvnw clean install

sudo cp /home/vagrant/RampUp_login/auth-api/scripts/RampUp-auth-api.service /lib/systemd/system/RampUp-auth-api.service
sudo cp /home/vagrant/RampUp_login/users-api/scripts/RampUp-users-api.service /lib/systemd/system/RampUp-users-api.service

sudo systemctl daemon-reload
sudo systemctl enable RampUp-users-api
sudo systemctl enable RampUp-auth-api
sudo systemctl start RampUp-users-api
sudo systemctl start RampUp-auth-api
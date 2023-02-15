#!/usr/bin/env bash
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
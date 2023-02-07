# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "web" do |web|
    web.vm.box = "hashicorp/bionic64"
    web.vm.network "private_network", ip: "192.168.33.10"
    web.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
    end
    web.vm.provision "shell", path: "setup_files/web_setup.sh", privileged: false
    web.vm.network "forwarded_port", guest: 8009, host: 1234
  end

  config.vm.define "auth" do |auth|
    auth.vm.box = "hashicorp/bionic64"
    auth.vm.network "private_network", ip: "192.168.33.11"
    auth.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
    auth.vm.provision "shell", path: "setup_files/auth_setup.sh", privileged: false
  end

  config.vm.define "todos" do |todos|
    todos.vm.box = "hashicorp/bionic64"
    todos.vm.network "private_network", ip: "192.168.33.12"
    todos.vm.provider "virtualbox" do |vb|
      vb.memory = "2048"
    end
    todos.vm.provision "shell", path: "setup_files/todos_setup.sh", privileged: false
  end
end
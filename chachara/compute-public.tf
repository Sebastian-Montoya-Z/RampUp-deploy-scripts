locals {
  service_names_pb = keys(yamldecode(file("${path.module}/docker-compose-nginx.yml"))["services"])
}

resource "aws_instance" "SMZ_nginx_server" {
  count = length(local.service_names_pb)

  ami = "ami-09cd747c78a9add63"
  instance_type = "t2.micro"
  subnet_id = var.pusn_id
  vpc_security_group_ids = [var.pusg_id]
  key_name = "tf-key-pair"

  user_data = <<EOF
#!/bin/bash
sudo apt-get update -y
sudo apt-get install \
ca-certificates \
curl \
gnupg \
lsb-release -y 
sudo mkdir -m 0755 -p /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo service docker start
sudo usermod -aG docker ubuntu
curl -SL https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
mkdir /home/ubuntu/app
cd /home/ubuntu/app
echo "${file("${path.module}/docker-compose-nginx.yml")}" >> /home/ubuntu/app/docker-compose.yml
sudo docker-compose up -d ${local.service_names_pb[count.index]}
  EOF

  tags = {
    Name = "SMZ_nginx_server"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
  volume_tags = {
    Name = "SMZ_nginx_server"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}
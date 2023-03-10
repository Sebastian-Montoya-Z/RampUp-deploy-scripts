locals {
  service_names = keys(yamldecode(file("${path.module}/docker-compose-services.yml"))["services"])
}

resource "aws_launch_configuration" "SMZ" {
  count = length(local.service_names)

  image_id           = "ami-09cd747c78a9add63"
  instance_type = "t2.micro"
  key_name      = "tf-key-pair"
  subnet_id = var.pvsn_id
  vpc_security_group_ids = [var.pvsg_id]

  user_data = <<EOF
#!/bin/bash
sudo apt-get update -y
sudo apt-get install \
ca-certificates \
curl \
gnupg \
lsb-release -y 
echo "nameserver 192.168.1.6" | sudo tee -a /etc/resolv.conf
sudo hostnamectl set-hostname ${local.service_names[count.index]}
echo "search ec2.internal" | sudo tee -a /etc/resolv.conf
echo "search domain.name" | sudo tee -a /etc/resolv.conf
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
echo "${file("${path.module}/docker-compose-services.yml")}" >> /home/ubuntu/app/docker-compose.yml
sudo docker-compose up -d ${local.service_names[count.index]}
  EOF

  tags = {
    Name = local.service_names[count.index]
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }

  volume_tags = {
    Name = local.service_names[count.index]
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}
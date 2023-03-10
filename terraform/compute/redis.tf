resource "aws_launch_configuration" "SMZ-redis" {
  name_prefix = "SMZ-redis"
  image_id           = "ami-09cd747c78a9add63"
  instance_type = "t2.micro"
  key_name      = "tf-key-pair"
  security_groups = [var.pvsg_id]

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
mkdir /home/ubuntu/app
cd /home/ubuntu/app
sudo docker run --name redis -p 6379:6379 --restart always -d redis:7.0 redis-server --bind ${var.nlb_ip}
  EOF
}

output "redis_config_id" {
  value = aws_launch_configuration.SMZ-redis.name
}
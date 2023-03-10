resource "aws_launch_configuration" "SMZ-users" {
  name_prefix = "SMZ-users"
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
sudo docker pull sebastianmontoyaz/rampup-perfi:users
sudo docker run --name users -p 8083:8083 -e SPRING_ZIPKIN_BASE_URL=http://${var.lb_ip}:9411 -e SERVER_PORT=8083 -e JWT_SECRET=PRFT -d sebastianmontoyaz/rampup-perfi:users
  EOF
}

output "users_config_id" {
  value = aws_launch_configuration.SMZ-users.name
}
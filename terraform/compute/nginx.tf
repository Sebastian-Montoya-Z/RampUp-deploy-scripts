resource "aws_launch_configuration" "SMZ-nginx" {
  name_prefix = "SMZ-nginx"
  image_id           = "ami-09cd747c78a9add63"
  instance_type = "t2.micro"
  key_name      = "tf-key-pair"
  security_groups = [var.pusg_id]

#   user_data = <<EOF
# #!/bin/bash
# sudo apt-get update -y
# sudo apt-get install \
# ca-certificates \
# curl \
# gnupg \
# lsb-release -y 
# sudo mkdir -m 0755 -p /etc/apt/keyrings
# sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# sudo echo \
# "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
# $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# sudo apt-get update -y
# sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
# sudo service docker start
# sudo usermod -aG docker ubuntu
# mkdir /home/ubuntu/app
# cd /home/ubuntu/app
# sudo docker pull sebastianmontoyaz/rampup-perfi:nginx
# sudo docker run --name nginx -p 8009:8009 -e LB_IP="${var.lb_ip}" -d sebastianmontoyaz/rampup-perfi:nginx
#   EOF
# }

  user_data = <<EOF
#!/bin/bash
sudo apt-get update -y
sudo apt-get -y install nginx
sudo unlink /etc/nginx/sites-available/default
echo 'server{
    listen 8009;
    server_name wach.quest;
    location / {
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header Host $host;
        proxy_pass http://${var.lb_ip}:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        # location /overview {
        #     proxy_pass http://127.0.0.1:3000$request_uri;
        #     proxy_redirect off;
        # }
    }
}' >> /etc/nginx/sites-available/myserver.config
sudo ln -sf /etc/nginx/sites-available/myserver.config /etc/nginx/sites-enabled/
sudo rm -rf /etc/nginx/sites-enabled/default
sudo rm -rf /etc/nginx/sites-available/default

sudo service nginx restart
sudo ufw allow 'Nginx Full'
  EOF
}

output "nginx_config_id" {
  value = aws_launch_configuration.SMZ-nginx.name
}
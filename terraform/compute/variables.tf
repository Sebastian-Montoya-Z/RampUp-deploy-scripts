variable "vpc_id" {
  description = "The ID of the VPC where the EC2 instance will be launched"
}
variable "pusn_id" {
  description = "The ID of the public subnet"
}
variable "pvsn_id" {
  description = "The ID of the private subnet"
}
variable "pusg_id" {
  description = "The ID of the public security group"
}
variable "pvsg_id" {
  description = "The ID of the private security group"
}
variable "lb_ip" {
  description = "load balancer ip"
}
variable "nlb_ip" {
  description = "load balancer ip"
}

data "aws_ec2_instance_type" "instance_type" {
  instance_type = "t2.micro"
}

resource "aws_key_pair" "tf-key-pair" {
    key_name = "tf-key-pair"
    public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
    algorithm = "RSA"
    rsa_bits  = 4096
}
resource "local_file" "tf-key" {
    content  = tls_private_key.rsa.private_key_pem
    filename = "${path.module}/tf-key-pair"
}


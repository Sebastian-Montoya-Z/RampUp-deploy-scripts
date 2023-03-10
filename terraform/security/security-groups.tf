variable "vpc_id" {
  description = "The ID of the VPC where the EC2 instance will be launched"
}
variable "pusn_id" {
  description = "The ID of the public subnet"
}
variable "pusn_idb" {
  description = "The ID of the public subnet in different az"
}
variable "pvsn_id" {
  description = "The ID of the private subnet"
}
variable "pvsn_idb" {
  description = "The ID of the private subnet"
}
data "aws_subnet" "pusn" {
  id = var.pusn_id
}
data "aws_subnet" "pusnb" {
  id = var.pusn_idb
}
data "aws_subnet" "pvsn" {
  id = var.pvsn_id
}
data "aws_subnet" "pvsnb" {
  id = var.pvsn_idb
}

resource "aws_security_group" "SMZ-public-sg" {
  name = "SMZ-public-sg"
  vpc_id = var.vpc_id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8009
    to_port = 8009
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SMZ-public-sg"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}

resource "aws_security_group" "SMZ-private-sg" {
  name = "SMZ-private-sg"
  vpc_id = var.vpc_id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0", data.aws_subnet.pusn.cidr_block, data.aws_subnet.pusnb.cidr_block, data.aws_subnet.pvsn.cidr_block, data.aws_subnet.pvsnb.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0", data.aws_subnet.pusn.cidr_block, data.aws_subnet.pusnb.cidr_block, data.aws_subnet.pvsn.cidr_block, data.aws_subnet.pvsnb.cidr_block]
  }
  tags = {
    Name = "SMZ-private-sg"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}

resource "aws_security_group_rule" "elb_http" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  security_group_id = aws_security_group.SMZ-private-sg.id
  source_security_group_id = aws_security_group.SMZ-private-sg.id
}
resource "aws_security_group_rule" "redis_ingress" {
  type        = "ingress"
  from_port   = 6379
  to_port     = 6379
  protocol    = "tcp"
  security_group_id = aws_security_group.SMZ-private-sg.id
  source_security_group_id = aws_security_group.SMZ-private-sg.id
}

output "pusg_id" {
  value = aws_security_group.SMZ-public-sg.id
}
output "pvsg_id" {
  value = aws_security_group.SMZ-private-sg.id
}
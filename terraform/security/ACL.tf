# variable "pvsn_id" {
#   description = "The ID of the public subnet"
# }

# data "aws_subnet" "pusn" {
#   id = var.pusn_id
# }

# resource "aws_network_acl" "SMZ-ACL" {
#   vpc_id = var.vpc_id

#   ingress {
#     rule_no = 100
#     action     = "allow"
#     protocol   = "tcp"
#     cidr_block = data.aws_subnet.pusn.cidr_block
#     from_port  = 8080
#     to_port    = 8080
#   }

#   egress {
#     rule_no = 100
#     action     = "allow"
#     protocol   = "tcp"
#     cidr_block = data.aws_subnet.pusn.cidr_block
#     from_port  = 8080
#     to_port    = 8080
#   }

#   ingress {
#     rule_no   = 200
#     action       = "allow"
#     protocol     = "tcp"
#     cidr_block   = data.aws_subnet.pusn.cidr_block
#     from_port  = 22
#     to_port    = 22
#   }

#   tags = {
#     Name = "SMZ-ACL"
#     project = "ramp-up-devops"
#     responsible = "sebastian.montoyaz"
#   }
# }

# resource "aws_network_acl_association" "SMZ-priv-pub" {
#   subnet_id      = var.pvsn_id
#   network_acl_id = aws_network_acl.SMZ-ACL.id
# }
resource "aws_vpc" "SMZ-VPC" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "SMZ-VPC"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}

resource "aws_subnet" "SMZ-public" {
  vpc_id = aws_vpc.SMZ-VPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "SMZ-public"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}

resource "aws_subnet" "SMZ-private" {
  vpc_id = aws_vpc.SMZ-VPC.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "SMZ-private"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}

resource "aws_subnet" "SMZ-public-1b" {
  vpc_id = aws_vpc.SMZ-VPC.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "SMZ-public-1b"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}

resource "aws_subnet" "SMZ-private-1b" {
  vpc_id = aws_vpc.SMZ-VPC.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "SMZ-private-1b"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}

resource "aws_internet_gateway" "SMZ-igw" {
  vpc_id = aws_vpc.SMZ-VPC.id
  tags = {
    Name = "SMZ-igw"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}

resource "aws_route_table" "SMZ-rt-east-1a" {
  vpc_id = aws_vpc.SMZ-VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.SMZ-igw.id
  }
  tags = {
    Name = "SMZ-rt-east-1a"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}

# resource "aws_route_table" "SMZ-rt-private" {
#   vpc_id = aws_vpc.SMZ-VPC.id
#   tags = {
#     Name = "SMZ-rt"
#     project = "ramp-up-devops"
#     responsible = "sebastian.montoyaz"
#   }
# }

resource "aws_route_table_association" "public_subnet_association_east_1a" {
  subnet_id = aws_subnet.SMZ-public.id
  route_table_id = aws_route_table.SMZ-rt-east-1a.id
}

resource "aws_route_table" "SMZ-rt-east-1b" {
  vpc_id = aws_vpc.SMZ-VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.SMZ-igw.id
  }
  tags = {
    Name = "SMZ-rt-east-1b"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}

resource "aws_route_table_association" "public_subnet_association_east_1b" {
  subnet_id = aws_subnet.SMZ-public-1b.id
  route_table_id = aws_route_table.SMZ-rt-east-1b.id
}

# resource "aws_route_table_association" "private_subnet_association" {
#   subnet_id = aws_subnet.SMZ-private.id
#   route_table_id = aws_route_table.SMZ-rt.id
# }

output "vpc_id" {
  value = aws_vpc.SMZ-VPC.id
}
output "pusn_id" {
  value = aws_subnet.SMZ-public.id
}
output "pvsn_id" {
  value = aws_subnet.SMZ-private.id
}
output "pusn_idb" {
  value = aws_subnet.SMZ-public-1b.id
}
output "pvsn_idb" {
  value = aws_subnet.SMZ-private-1b.id
}
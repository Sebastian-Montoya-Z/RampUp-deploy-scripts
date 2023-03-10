data "aws_eip" "nat-eip" {
  id = "eipalloc-04ad28fea97bd728a"
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = data.aws_eip.nat-eip.id
  connectivity_type = "public"
  subnet_id     = aws_subnet.SMZ-public.id

  tags = {
    Name = "SMZ-nat-gateway"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}

resource "aws_route_table" "NAT_route_table" {

  vpc_id = aws_vpc.SMZ-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "SMZ-sn-nat-rt"
    project = "ramp-up-devops"
    responsible = "sebastian.montoyaz"
  }
}
resource "aws_route_table_association" "associate_routetable_to_private_subnet" {
  subnet_id      = aws_subnet.SMZ-private.id
  route_table_id = aws_route_table.NAT_route_table.id
}
resource "aws_route_table" "Public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.route_table_igw
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "Publicsubnet1" {
  subnet_id      = var.ps1_rt_tag
  route_table_id = var.ps1_rt_tag
}

resource "aws_route_table_association" "Publicsubnet2" {
  subnet_id      = var.ps2_rt_tag
  route_table_id = var.ps2_rt_tag
}  
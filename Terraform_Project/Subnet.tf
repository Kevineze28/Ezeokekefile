resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.ps1_cidr
  availability_zone = var.ps1_az
  tags = {
    Name = "public-subnet1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.ps2_cidr
  availability_zone = var.ps2_az
  tags = {
    Name = "public-subnet2"
  }
}
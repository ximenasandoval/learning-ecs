resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "private_subnet" {
  availability_zone = var.private_subnet_availability_zone
  cidr_block        = var.private_subnet_cidr
  vpc_id            = aws_vpc.vpc.id
}

resource "aws_subnet" "public_subnet" {
  availability_zone = var.public_subnet_availability_zone
  cidr_block        = var.public_subnet_cidr
  vpc_id            = aws_vpc.vpc.id
}

resource "aws_internet_gateway" "vpc_internet_gateway" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_internet_gateway.id
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table_association" "private_subnet_rt_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

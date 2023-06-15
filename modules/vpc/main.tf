resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name          = var.name
    resource_type = "AWS VPC"
  }
}

resource "aws_subnet" "private_subnet" {
  availability_zone = var.private_subnet_availability_zone
  cidr_block        = var.private_subnet_cidr
  vpc_id            = aws_vpc.vpc.id
  tags = {
    Name          = "${var.name}-private-subnet"
    resource_type = "AWS Subnet"
  }
}

resource "aws_subnet" "public_subnet" {
  availability_zone = var.public_subnet_availability_zone
  cidr_block        = var.public_subnet_cidr
  vpc_id            = aws_vpc.vpc.id
  tags = {
    Name          = "${var.name}-public-subnet"
    resource_type = "AWS Subnet"
  }
}

resource "aws_internet_gateway" "vpc_internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name          = "${var.name}-ig"
    resource_type = "AWS Internet Gateway"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_internet_gateway.id
  }
  tags = {
    Name          = "${var.name}-public-rt"
    resource_type = "AWS Route table"
  }
}

resource "aws_route_table_association" "public_subnet_rt_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  tags = {
    Name          = "${var.name}-private-rt"
    resource_type = "AWS Route table"
  }
}

resource "aws_route_table_association" "private_subnet_rt_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_security_group" "public_security_group" {
  name        = "${var.name}-public-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Allow TLS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name          = "${var.name}-public-sg"
    resource_type = "AWS Security Group"
  }
}

resource "aws_security_group" "private_security_group" {
  name        = "${var.name}-private-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "Allow TLS from within VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.vpc.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.vpc.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name          = "${var.name}-private-sg"
    resource_type = "AWS Security Group"
  }
}

resource "aws_eip" "private_nat_eip" {
  tags = {
    Name          = "${var.name}-nat-eip"
    resource_type = "AWS EIP"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  connectivity_type = "public"
  allocation_id     = aws_eip.private_nat_eip.id
  subnet_id         = aws_subnet.public_subnet.id
  tags = {
    Name          = "${var.name}-nat"
    resource_type = "AWS Nat Gateway"
  }
}

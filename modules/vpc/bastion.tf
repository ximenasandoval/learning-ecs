resource "aws_iam_instance_profile" "bastion-ssm-instance-profile" {
  count = var.create_bastion_host ? 1 : 0
  name  = "BastionHostSSMProfile"
  role  = aws_iam_role.bastion-host-role.0.name
  tags = {
    resource_type = "AWS IAM instance profile"
  }
}

resource "aws_iam_role" "bastion-host-role" {
  count = var.create_bastion_host ? 1 : 0
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  name = "BastionHostSSMRole"
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
  path = "/"
}

resource "aws_instance" "bastion" {
  count = var.create_bastion_host ? 1 : 0

  ami                         = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.bastion-ssm-instance-profile.0.name
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public_subnet.id
  security_groups             = [aws_security_group.bastion-security-group.0.id]
  tags = {
    resource_type = "AWS EC2 instance"
    Name          = "${var.name}-bastion"
  }
}

resource "aws_security_group" "bastion-security-group" {
  count       = var.create_bastion_host ? 1 : 0
  name        = "${var.name}-bastion_host_sg"
  description = "Bastion host Security Group"
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name          = "${var.name}-bastion_host_sg"
    resource_type = "AWS Security Group"
  }
}

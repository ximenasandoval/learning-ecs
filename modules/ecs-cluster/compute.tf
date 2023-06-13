resource "aws_iam_role" "ecs_instances_iam_role" {
  name = "ECSServiceAccount-${var.name}"
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
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  ]
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ECSInstanceProfile-${var.name}"
  role = aws_iam_role.ecs_instances_iam_role.name
}

resource "aws_security_group" "ecs_workers_sg" {
  name        = "${var.name}-workers-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [data.aws_vpc.vpc.cidr_block]
    ipv6_cidr_blocks = [data.aws_vpc.vpc.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name          = "${var.name}-workers-sg"
    resource_type = "AWS Security Group"
  }

}

resource "aws_launch_configuration" "ecs_launch_config" {
  image_id             = data.aws_ami.amazon_ecs_optimized_ami.id
  iam_instance_profile = aws_iam_instance_profile.ecs_instance_profile.name
  security_groups      = [aws_security_group.ecs_workers_sg.id]
  user_data            = "#!/bin/bash\necho ECS_CLUSTER=${var.name} >> /etc/ecs/ecs.config"
  instance_type        = var.instance_type
}

resource "aws_autoscaling_group" "ecs_workers_asg" {
  name                 = "${var.name}-asg"
  vpc_zone_identifier  = [var.subnet_id]
  launch_configuration = aws_launch_configuration.ecs_launch_config.name

  desired_capacity          = 1
  min_size                  = 0
  max_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
}

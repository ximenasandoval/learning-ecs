resource "aws_alb" "app_load_balancer" {
  name               = "${var.name}-alb"
  load_balancer_type = "application"
  security_groups    = [var.public_security_group]

  subnet_mapping {
    subnet_id = var.public_subnet_id
  }
  tags = {
    Name          = "${var.name}-alb"
    resource_type = "AWS ALB"
  }
}

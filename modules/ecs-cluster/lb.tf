resource "aws_alb" "app_load_balancer" {
  name = "${var.name}-alb"
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.name
  tags = {
    Name          = var.name
    resource_type = "AWS ECS cluster"
  }
}

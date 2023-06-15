resource "aws_ecs_task_definition" "task_definition" {
  family                = var.name
  container_definitions = jsonencode(templatefile("templates/task_definition.tftpl"))
}

resource "aws_ecs_service" "ecs_service" {
  name            = var.name
  cluster         = var.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
}



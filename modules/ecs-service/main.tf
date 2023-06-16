resource "aws_ecs_service" "ecs_service" {
  name            = var.name
  cluster         = data.aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
}

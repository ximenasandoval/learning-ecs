output "ecs-cluster" {
  description = "ECS cluster name"
  value = aws_ecs_cluster.ecs_cluster.name 
}
output "ecs-cluster" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.ecs_cluster.name
}

output "alb" {
  description = "ALB used created for cluster"
  value       = aws_alb.app_load_balancer.arn
}

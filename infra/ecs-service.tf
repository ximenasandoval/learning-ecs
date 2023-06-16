module "ecs_service" {
  source                     = "./../modules//ecs-service"
  name                       = "2048-service"
  cluster_name               = module.aws_ecs_cluster.ecs_cluster
  create_task_execution_role = true
  ecs_task_container_definitions = [
    {
      name      = "container name"
      image     = "alexwhen/docker-2048"
      cpu       = 1
      memory    = 256
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 5000
        }
      ]
    }
  ]
}

variable "ecs_task_container_definitions" {
  description = "ECS task definition containers"
  type = list(object({
    name      = string
    image     = string
    cpu       = number
    memory    = number
    essential = bool
    portMappings = list(object({
      containerPort = number
      hostPort      = number
    }))
  }))
}

variable "ecs_task_container_definitions" {
  description = <<EOT
  ECS task definition containers, in the form:
  [
    {
      name         = "container name"
      image        = "image name"
      cpu          = 5
      memory       = 256
      essential    = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 5000
        }
      ]
    }, ...
  ]
  EOT

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

variable "create_task_execution_role" {
  description = "Create new task execution role"
  type        = bool
  default     = true
}

variable "cluster_name" {
  description = "ECS cluster where to place the service"
  type        = string
}

variable "name" {
  description = "Name of the ECS service"
  type        = string
}

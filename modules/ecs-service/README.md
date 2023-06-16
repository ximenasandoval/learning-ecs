## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | ECS cluster where to place the service | `string` | n/a | yes |
| create\_task\_execution\_role | Create new task execution role | `bool` | `true` | no |
| ecs\_task\_container\_definitions | ECS task definition containers, in the form:<br>  [<br>    {<br>      name         = "container name"<br>      image        = "image name"<br>      cpu          = 5<br>      memory       = 256<br>      essential    = true<br>      portMappings = [<br>        {<br>          containerPort = 8080<br>          hostPort      = 5000<br>        }<br>      ]<br>    }, ...<br>  ] | <pre>list(object({<br>    name      = string<br>    image     = string<br>    cpu       = number<br>    memory    = number<br>    essential = bool<br>    portMappings = list(object({<br>      containerPort = number<br>      hostPort      = number<br>    }))<br>  }))</pre> | n/a | yes |
| name | Name of the ECS service | `string` | n/a | yes |

## Outputs

No output.

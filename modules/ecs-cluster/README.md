## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| instance\_type | Instance type to use for ECS ASG, defaults to t2.micro | `string` | `"t2.micro"` | no |
| name | Name of the ECS cluster | `string` | n/a | yes |
| private\_security\_group | Private security group to use for ALB | `string` | n/a | yes |
| private\_subnet\_id | Subnet id to place the ECS instances in | `string` | n/a | yes |
| public\_security\_group | Public security group to use for ALB | `string` | n/a | yes |
| public\_subnet\_id | Subnet id to place the ALB | `string` | n/a | yes |
| vpc\_id | VPC id to place the ECS instances in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| alb | ALB used created for cluster |
| ecs\_cluster | ECS cluster name |

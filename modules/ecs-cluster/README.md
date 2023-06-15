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
| subnet\_id | Subnet id to place the ECS instances in | `string` | n/a | yes |
| vpc\_id | VPC id to place the ECS instances in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ecs-cluster | ECS cluster name |

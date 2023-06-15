## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_bastion\_host | Bool to create bastion host in VPC, defaults to true | `bool` | `true` | no |
| name | VPC name | `string` | n/a | yes |
| private\_subnet\_availability\_zone | AZ to place private subnet in | `string` | `null` | no |
| private\_subnet\_cidr | CIDR block to use for private subnet | `string` | n/a | yes |
| public\_subnet\_availability\_zone | AZ to place public subnet in | `string` | `null` | no |
| public\_subnet\_cidr | CIDR block to use for public subnet | `string` | n/a | yes |
| vpc\_cidr | CIDR block to use for VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| private\_security\_group | ID of private security group in VPC |
| public\_security\_group | ID of public security group in VPC |
| vpc\_id | ID of the VPC |
| vpc\_private\_subnet | ID of the private subnet |
| vpc\_public\_subnet | ID of the public subnet |

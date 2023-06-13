variable "name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "instance_type" {
  description = "Instance type to use for ECS ASG, defaults to t2.micro"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = ""
  type        = string
}

variable "vpc_id" {
  description = "VPC id to place the instances in"
  type        = string
}

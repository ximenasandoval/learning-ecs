variable "name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "instance_type" {
  description = "Instance type to use for ECS ASG, defaults to t2.micro"
  type        = string
  default     = "t2.micro"
}

variable "private_subnet_id" {
  description = "Subnet id to place the ECS instances in"
  type        = string
}

variable "public_subnet_id" {
  description = "Subnet id to place the ALB"
  type        = string
}

variable "public_security_group" {
  description = "Public security group to use for ALB"
  type        = string
}

variable "private_security_group" {
  description = "Private security group to use for ALB"
  type        = string
}

variable "vpc_id" {
  description = "VPC id to place the ECS instances in"
  type        = string
}

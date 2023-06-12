variable "private_subnet_availability_zone" {
  description = "AZ to place private subnet in"
  type        = string
  default     = null
}

variable "private_subnet_cidr" {
  description = "CIDR block to use for private subnet"
  type        = string
}

variable "public_subnet_availability_zone" {
  description = "AZ to place public subnet in"
  type        = string
  default     = null
}

variable "public_subnet_cidr" {
  description = "CIDR block to use for public subnet"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block to use for VPC"
  type        = string
}

output "vpc_public_subnet" {
  description = "ID of the public subnet"
  value       = aws_subnet.private_subnet.id
}

output "vpc_private_subnet" {
  description = "ID of the private subnet"
  value       = aws_subnet.private_subnet.id
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.vpc.id
}


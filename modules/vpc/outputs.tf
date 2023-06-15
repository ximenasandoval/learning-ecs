output "private_security_group" {
  description = "ID of private security group in VPC"
  value = aws_security_group.private_security_group.id
}

output "public_security_group" {
  description = "ID of public security group in VPC"
  value = aws_security_group.public_security_group.id
}

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


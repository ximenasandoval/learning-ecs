module "aws_vpc" {
  source = "./../modules//vpc"
  name   = "learning-ecs-vpc"

  vpc_cidr = "10.0.0.0/16"

  public_subnet_cidr  = "10.0.0.0/24"
  private_subnet_cidr = "10.0.1.0/24"
}

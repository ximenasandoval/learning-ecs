module "aws_ecs_cluster" {
  source = "./../modules//ecs-cluster"
  name   = "learning-ecs"

  private_subnet_id = module.aws_vpc.vpc_private_subnet
  private_security_group = module.aws_vpc.private_security_group
  public_subnet_id = module.aws_vpc.vpc_public_subnet
  public_security_group = module.aws_vpc.public_security_group
  
  vpc_id            = module.aws_vpc.vpc_id
}

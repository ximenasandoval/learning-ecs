module "aws_ecs_cluster" {
  source = "./../modules//ecs-cluster"
  name   = "learning-ecs"

  subnet_id = module.aws_vpc.vpc_private_subnet
  vpc_id    = module.aws_vpc.vpc_id
}

provider "aws" {
  region = var.region
}

module "vpc" {

  source = "git::https://github.com/Kalyani-Bambal/terraform-module.git//modules/vpc?ref=v13.0.9"
  env            = var.env
  cidr_block     = var.cidr_block
  tags           = var.tags
  region         = var.region
  public_subnet  = var.public_subnets
  private_subnet = var.private_subnets
  azs            = var.azs
}

module "eks" {

  source = "git::https://github.com/Kalyani-Bambal/terraform-module.git//modules/eks?ref=v13.0.9"
  env             = var.env
  cluster_name    = "${var.env}-eks"
  cluster_version = var.cluster_version

  vpc_id              = module.vpc.aws_vpc
  private_subnet_ids  = module.vpc.private_subnet_ids
  desired_size        = var.desired_size
  max_size            = var.max_size
  min_size            = var.min_size
  node_instance_types = var.node_instance_types

  allowed_cidr_blocks = var.allowed_cidr_blocks
  # bastion_role_arn     = module.bastion.role_arn
  bastion_access_role_arn = module.bastion.bastion_access_role_arn
  tags = var.tags
}


module "bastion" {

  source = "git::https://github.com/Kalyani-Bambal/terraform-module.git//modules//bastion?ref=v13.0.9"
  env           = var.env
  # vpc_id                = module.vpc.aws_vpc
  # public_subnet_ids     = module.vpc.public_subnet_ids

  # ami           = var.bastion_ami
  # instance_type = var.bastion_instance_type
  # key_name      = var.bastion_key_name
  # allowed_ssh_cidr = var.allowed_ssh_cidr
  tags       = var.tags
  bastion_assume_role_principals = var.bastion_assume_role_principals
}

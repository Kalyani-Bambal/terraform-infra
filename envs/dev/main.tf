provider "aws" {
  region = var.region
}

module "vpc" {
  source = "git::https://github.com/Kalyani-Bambal/terraform-module.git//modules/vpc?ref=main"

  env            = var.env
  cidr_block     = var.cidr_block
  tags           = var.tags
  region         = var.region
  public_subnet  = var.public_subnets
  private_subnet = var.private_subnets
  azs            = var.azs
}

module "eks" {
  source = "git::https://github.com/Kalyani-Bambal/terraform-module.git//modules/eks?ref=main"

  env                = var.env
  cluster_name       = "${var.env}-eks"
  cluster_version    = var.cluster_version

  vpc_id             = module.vpc.aws_vpc
  private_subnet_ids = module.vpc.private_subnet_ids

  tags = var.tags
}

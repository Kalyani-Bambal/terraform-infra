provider "aws" {
  region = var.region
}

module "vpc" {
  source         = "../../modules/vpc"
  env            = var.env
  cidr_block     = var.cidr_block
  tags           = var.tags
  region         = var.region
  public_subnet  = var.public_subnets
  private_subnet = var.private_subnets
  azs            = var.azs
}
provider "aws" {
  region = var.region
}

module "vpc" {
  source         = "git::https://github.com/Kalyani-Bambal/terraform-module.git//modules/vpc?ref=main"
  env            = var.env
  cidr_block     = var.cidr_block
  tags           = var.tags
  region         = var.region
  public_subnet  = var.public_subnets
  private_subnet = var.private_subnets
  azs            = var.azs
}
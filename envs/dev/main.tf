provider "aws" {
  region = var.region
}


module "vpc" {
  source        = "../../modules/vpc"
  region        = var.region
  env           = var.env
  cidr_block    = var.cidr_block
  tags          = var.tags
  public_subnet = var.public_subnet
  azs           = var.azs
}
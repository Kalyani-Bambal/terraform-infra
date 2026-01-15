output "aws_vpc" {
  value = module.vpc.aws_vpc
}

output "region" {
  value = var.region
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}
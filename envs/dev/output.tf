output "aws_vpc" {
  value = module.vpc.aws_vpc
}

output "region" {
  value = var.region
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_ca" {
  value = module.eks.cluster_ca
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "bastion_access_role_arn" {
  value = module.bastion.bastion_access_role_arn
}
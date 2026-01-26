module "vpc" {

  source = "git::https://github.com/Kalyani-Bambal/terraform-module.git//modules/vpc?ref=v13.0.17"
  env            = var.env
  cidr_block     = var.cidr_block
  tags           = var.tags
  region         = var.region
  public_subnet  = var.public_subnets
  private_subnet = var.private_subnets
  azs            = var.azs
}

module "eks" {

  source = "git::https://github.com/Kalyani-Bambal/terraform-module.git//modules/eks?ref=v13.0.17"
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
  bastion_access_role_arn = module.bastion.bastion_access_role_arn
  tags = var.tags
}


module "bastion" {

  source = "git::https://github.com/Kalyani-Bambal/terraform-module.git//modules//bastion?ref=v13.0.17"
  env           = var.env
  tags       = var.tags
  bastion_assume_role_principals = var.bastion_assume_role_principals
}

module "add-ons" {
  source = "git::https://github.com/Kalyani-Bambal/terraform-module.git//modules//add-ons?ref=v13.0.17"

  cluster_name       = module.eks.cluster_name
  cni_version        = var.cni_version
  coredns_version    = var.coredns_version
  kube_proxy_version = var.kube_proxy_version
  # ebs_csi_driver_version   = var.ebs_csi_driver_version
  # efs_csi_driver_version   = var.efs_csi_driver_version
}


module "argocd" {
  source = "git::https://github.com/Kalyani-Bambal/terraform-module.git//modules//argocd?ref=v13.0.18"

  cluster_name = module.eks.cluster_name
  values = [
    file("${path.module}/argocd-values.yaml")
  ]

  bootstrap_file = "${path.module}/argocd-bootstrap.yaml"
}

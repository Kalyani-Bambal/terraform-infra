env        = "dev"
cidr_block = "10.10.0.0/16"
tags = {
  "name" = "dev"
}
azs             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
public_subnets  = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
private_subnets = ["10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]
region          = "ap-south-1"

cluster_name        = "shared-cluster"
cluster_version     = "1.34"
desired_size        = 1
max_size            = 3
min_size            = 1
node_instance_types = ["t3.small"]
allowed_cidr_blocks = ["10.10.0.0/16"]  # VPC CIDR (bastion included
common_tags = {
  "Project"     = "TerraformInfra"
  "Environment" = "Development"
}

bastion_assume_role_principals = [
  "arn:aws:iam::358871393576:user/Ashutosh-Bambal",
  "arn:aws:iam::358871393576:user/Kalyani-Bambal"
]

cni_version        = "v1.18.1-eksbuild.1"
coredns_version    = "v1.11.1-eksbuild.4"
kube_proxy_version = "v1.34.1-eksbuild.2"
ebs_csi_driver_version = "v1.54.0-eksbuild.1"
efs_csi_driver_version = "v2.2.0-eksbuild.1"



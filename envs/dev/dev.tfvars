env        = "dev"
cidr_block = "10.10.0.0/16"
tags = {
  "name" = "dev"
}
azs             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
public_subnets  = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
private_subnets = ["10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]
region          = "ap-south-1"

cluster_name    = "shared-cluster"
cluster_version = "1.34"
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
allowed_ssh_cidrs = ["0.0.0.0/0"]
bastion_ami = "ami-02b8269d5e85954ef"
bastion_instance_type = "t3.small"
bastion_key_name = "bastion-key"
common_tags = {
  "Project"     = "TerraformInfra"
  "Environment" = "Development"
}
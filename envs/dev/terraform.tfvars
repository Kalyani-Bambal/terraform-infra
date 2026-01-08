region     = "ap-south-1"
env        = "dev"
cidr_block = "10.10.0.0/16"
tags = {
  "name" = "dev"
}

azs           = ["ap-south-1a", "ap-south-1b"]
public_subnet = ["10.10.1.0/24", "10.10.2.0/24"]
variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the VPC"
  type        = map(string)
}

variable "region" {
  type = string
}

variable "public_subnets" {
  description = "Public Subnets"
  type        = list(string)
}

variable "azs" {
  description = "Availabilty Zone"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private Subnets"
  type        = list(string)
}

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "vpc_id" {
  description = "The ID of the VPC to deploy EKS into"
  type        = string
  default     = ""
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for EKS cluster"
  type        = list(string)
  default     = []
}

variable "desired_size" {
  type    = number
  default = 2
}

variable "max_size" {
  type    = number
  default = 4
}

variable "min_size" {
  type    = number
  default = 1
}

variable "node_instance_types" {
  type = list(string)
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access EKS private endpoint"
  type = list(string)
  default = [  ]
}


variable "public_subnet_ids" {
  description = "Public Subnet ID for Bastion Host"
  type        =  list(string)
  default     = []
}

variable "common_tags" {
  description = "Common tags for resources"
  type        = map(string)
  default     = {}
}

variable "bastion_assume_role_principals" {
  description = "List of principals allowed to assume the bastion role"
  type        = list(string)
  default     = []
}

variable "cni_version" {
  type = string
}

variable "coredns_version" {
  type = string
}

variable "kube_proxy_version" {
  type = string
}

variable "ebs_csi_driver" {
  type = string
}


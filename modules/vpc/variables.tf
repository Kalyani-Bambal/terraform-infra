variable "cidr_block"{
    description = "The cidr block for the vpc"
    type = string
}

variable "env" {
  description = "Environment name"
  type = string
}

variable "tags" {
  description = "tags to apply to the vpc"
  type = map(string)
}

variable "region" {
  type = string
}

variable "public_subnet" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}

variable "private_subnet" {
  type = list(string)
}
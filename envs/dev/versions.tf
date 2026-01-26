terraform {
  required_providers {
    kubectl = {
        source = "gavinbunney/kubectl"
        version = "~> 1.14"
    }

    helm = {
        source = "hashicorp/helm"
        version = "~> 2.13"
    }

    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}
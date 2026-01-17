terraform {
  backend "s3" {

    bucket         = "my-terraform-state-kalyani-123"
    key            = "prod-terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "prod-terraform-locks"
    encrypt        = true

  }
}
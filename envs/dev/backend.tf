terraform {
  backend "s3" {
    bucket = "my-terraform-state-kalyani-abc"
    key = "dev/terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "terraform-locks1"
    encrypt = true
  }
}
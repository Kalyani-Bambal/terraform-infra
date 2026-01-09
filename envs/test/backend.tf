terraform {
  backend "s3" {

    bucket         = "my-terraform-state-kalyani-abc"
    key            = "test-terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "test-terraform-locks"
    encrypt        = true

  }
}
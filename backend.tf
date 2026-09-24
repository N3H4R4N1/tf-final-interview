terraform {
  backend "s3" {
    bucket         = "tf-interview-neha"
    key            = "vpc-peering/dev/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}
variable "aws_region" {
  description = "AWS region where Terraform backend resources are created"
  type        = string
  default     = "ap-south-1"
}

variable "state_bucket_name" {
  description = "Globally unique S3 bucket name used to store Terraform state"
  type        = string
}

variable "dynamodb_table_name" {
  description = "DynamoDB table used for Terraform state locking"
  type        = string
  default     = "terraform-state-lock"
}
output "state_bucket_name" {
  description = "S3 bucket used for Terraform remote state"
  value       = aws_s3_bucket.terraform_state.id
}

output "state_bucket_arn" {
  description = "ARN of the Terraform state S3 bucket"
  value       = aws_s3_bucket.terraform_state.arn
}

output "dynamodb_table_name" {
  description = "DynamoDB table used for Terraform state locking"
  value       = aws_dynamodb_table.terraform_lock.name
}

output "dynamodb_table_arn" {
  description = "ARN of the Terraform state locking DynamoDB table"
  value       = aws_dynamodb_table.terraform_lock.arn
}
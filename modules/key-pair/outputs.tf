output "key_name" {
  description = "AWS EC2 Key Pair name"
  value       = aws_key_pair.this.key_name
}

output "key_pair_id" {
  description = "AWS EC2 Key Pair ID"
  value       = aws_key_pair.this.key_pair_id
}

output "key_pair_arn" {
  description = "AWS EC2 Key Pair ARN"
  value       = aws_key_pair.this.arn
}

output "private_key_path" {
  description = "Local path of the generated SSH private key"
  value       = local_sensitive_file.private_key.filename
}
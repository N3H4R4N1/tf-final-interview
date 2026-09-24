# ============================================================
# VPC Outputs
# ============================================================

output "vpc_1_id" {
  description = "ID of VPC-1"
  value       = module.vpc_1.vpc_id
}

output "vpc_1_arn" {
  description = "ARN of VPC-1"
  value       = module.vpc_1.vpc_arn
}

output "vpc_2_id" {
  description = "ID of VPC-2"
  value       = module.vpc_2.vpc_id
}

output "vpc_2_arn" {
  description = "ARN of VPC-2"
  value       = module.vpc_2.vpc_arn
}

# ============================================================
# Subnet Outputs
# ============================================================

output "vpc_1_public_subnet_id" {
  description = "Public subnet ID in VPC-1"
  value       = module.vpc_1.public_subnet_id
}

output "vpc_2_public_subnet_id" {
  description = "Public subnet ID in VPC-2"
  value       = module.vpc_2.public_subnet_id
}

# ============================================================
# Internet Gateway Outputs
# ============================================================

output "vpc_1_internet_gateway_id" {
  description = "Internet Gateway ID for VPC-1"
  value       = module.vpc_1.internet_gateway_id
}

output "vpc_2_internet_gateway_id" {
  description = "Internet Gateway ID for VPC-2"
  value       = module.vpc_2.internet_gateway_id
}

# ============================================================
# Route Table Outputs
# ============================================================

output "vpc_1_route_table_id" {
  description = "Public route table ID for VPC-1"
  value       = module.vpc_1.public_route_table_id
}

output "vpc_2_route_table_id" {
  description = "Public route table ID for VPC-2"
  value       = module.vpc_2.public_route_table_id
}

# ============================================================
# NACL Outputs
# ============================================================

output "vpc_1_network_acl_id" {
  description = "Network ACL ID for VPC-1"
  value       = module.vpc_1.network_acl_id
}

output "vpc_2_network_acl_id" {
  description = "Network ACL ID for VPC-2"
  value       = module.vpc_2.network_acl_id
}

# ============================================================
# VPC Peering
# ============================================================

output "vpc_peering_connection_id" {
  description = "VPC peering connection ID"
  value       = module.vpc_peering.peering_connection_id
}

# ============================================================
# Key Pair
# ============================================================

output "bastion_key_pair_name" {
  description = "Terraform-managed EC2 key pair name"
  value       = module.key_pair.key_name
}

output "bastion_key_pair_id" {
  description = "Terraform-managed EC2 key pair ID"
  value       = module.key_pair.key_pair_id
}

output "bastion_key_pair_arn" {
  description = "Terraform-managed EC2 key pair ARN"
  value       = module.key_pair.key_pair_arn
}

output "bastion_private_key_path" {
  description = "Local path of the generated SSH private key"
  value       = module.key_pair.private_key_path
}

# ============================================================
# Bastion-1
# ============================================================

output "bastion_1_instance_id" {
  description = "Bastion-1 EC2 instance ID"
  value       = module.bastion_1.instance_id
}

output "bastion_1_arn" {
  description = "Bastion-1 EC2 ARN"
  value       = module.bastion_1.instance_arn
}

output "bastion_1_private_ip" {
  description = "Bastion-1 private IP"
  value       = module.bastion_1.private_ip
}

output "bastion_1_public_ip" {
  description = "Bastion-1 public IP"
  value       = module.bastion_1.public_ip
}

output "bastion_1_security_group_id" {
  description = "Bastion-1 security group ID"
  value       = module.bastion_1.security_group_id
}

output "bastion_1_security_group_arn" {
  description = "Bastion-1 security group ARN"
  value       = module.bastion_1.security_group_arn
}

# ============================================================
# Bastion-2
# ============================================================

output "bastion_2_instance_id" {
  description = "Bastion-2 EC2 instance ID"
  value       = module.bastion_2.instance_id
}

output "bastion_2_arn" {
  description = "Bastion-2 EC2 ARN"
  value       = module.bastion_2.instance_arn
}

output "bastion_2_private_ip" {
  description = "Bastion-2 private IP"
  value       = module.bastion_2.private_ip
}

output "bastion_2_public_ip" {
  description = "Bastion-2 public IP"
  value       = module.bastion_2.public_ip
}

output "bastion_2_security_group_id" {
  description = "Bastion-2 security group ID"
  value       = module.bastion_2.security_group_id
}

output "bastion_2_security_group_arn" {
  description = "Bastion-2 security group ARN"
  value       = module.bastion_2.security_group_arn
}
variable "aws_region" {
  description = "AWS region where resources will be deployed"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
  default     = "aws-vpc-peering-assignment"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_1_cidr" {
  description = "CIDR block for VPC-1"
  type        = string
  default     = "10.1.0.0/16"
}

variable "vpc_2_cidr" {
  description = "CIDR block for VPC-2"
  type        = string
  default     = "10.2.0.0/16"
}

variable "vpc_1_public_subnet_cidr" {
  description = "Public subnet CIDR for VPC-1"
  type        = string
  default     = "10.1.1.0/24"
}

variable "vpc_2_public_subnet_cidr" {
  description = "Public subnet CIDR for VPC-2"
  type        = string
  default     = "10.2.1.0/24"
}

variable "vpc_1_availability_zone" {
  description = "Availability Zone for VPC-1 public subnet"
  type        = string
  default     = "ap-south-1a"
}

variable "vpc_2_availability_zone" {
  description = "Availability Zone for VPC-2 public subnet"
  type        = string
  default     = "ap-south-1b"
}

variable "instance_type" {
  description = "EC2 instance type for both bastion hosts"
  type        = string
  default     = "t3.micro"
}

variable "allowed_ssh_cidr" {
  description = "Public IPv4 CIDR permitted to SSH to bastion hosts"
  type        = string

  validation {
    condition     = can(cidrhost(var.allowed_ssh_cidr, 0))
    error_message = "allowed_ssh_cidr must be a valid IPv4 CIDR, for example 203.0.113.10/32."
  }
}

variable "bastion_key_name" {
  description = "Name of the Terraform-managed AWS EC2 key pair"
  type        = string
  default     = "vpc-peering-bastion-key"
}
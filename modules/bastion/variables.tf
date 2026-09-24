variable "name" {
  description = "Name of the bastion host"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the bastion will be deployed"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the bastion will be deployed"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "AWS EC2 Key Pair name"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR permitted to connect to the bastion using SSH"
  type        = string
}

variable "allowed_icmp_cidr" {
  description = "CIDR permitted to initiate ICMP. Null disables ICMP ingress."
  type        = string
  default     = null
}
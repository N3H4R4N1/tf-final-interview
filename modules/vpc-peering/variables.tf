variable "name" {
  description = "Name of the VPC peering connection"
  type        = string
}

variable "vpc_1_id" {
  description = "ID of VPC-1"
  type        = string
}

variable "vpc_2_id" {
  description = "ID of VPC-2"
  type        = string
}

variable "vpc_1_cidr" {
  description = "CIDR block of VPC-1"
  type        = string
}

variable "vpc_2_cidr" {
  description = "CIDR block of VPC-2"
  type        = string
}

variable "vpc_1_route_table_id" {
  description = "Route table ID for VPC-1"
  type        = string
}

variable "vpc_2_route_table_id" {
  description = "Route table ID for VPC-2"
  type        = string
}
aws_region   = "ap-south-1"
project_name = "aws-vpc-peering-assignment"
environment  = "dev"

vpc_1_cidr = "10.1.0.0/16"
vpc_2_cidr = "10.2.0.0/16"

vpc_1_public_subnet_cidr = "10.1.1.0/24"
vpc_2_public_subnet_cidr = "10.2.1.0/24"

vpc_1_availability_zone = "ap-south-1a"
vpc_2_availability_zone = "ap-south-1b"

instance_type = "t3.micro"

# Replace this with your actual public IPv4 address.
# Example: 49.36.100.20/32
allowed_ssh_cidr = "223.190.84.44/32"

# Terraform will create this AWS EC2 Key Pair.
bastion_key_name = "vpc-peering-bastion-key"
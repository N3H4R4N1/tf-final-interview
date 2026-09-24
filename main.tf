# ============================================================
# VPC-1
# ============================================================

module "vpc_1" {
  source = "./modules/vpc"

  name               = "vpc-1"
  vpc_cidr           = var.vpc_1_cidr
  public_subnet_cidr = var.vpc_1_public_subnet_cidr
  availability_zone  = var.vpc_1_availability_zone
}

# ============================================================
# VPC-2
# ============================================================

module "vpc_2" {
  source = "./modules/vpc"

  name               = "vpc-2"
  vpc_cidr           = var.vpc_2_cidr
  public_subnet_cidr = var.vpc_2_public_subnet_cidr
  availability_zone  = var.vpc_2_availability_zone
}

# ============================================================
# VPC Peering
# ============================================================

module "vpc_peering" {
  source = "./modules/vpc-peering"

  name = "vpc1-vpc2-peering"

  vpc_1_id   = module.vpc_1.vpc_id
  vpc_2_id   = module.vpc_2.vpc_id
  vpc_1_cidr = var.vpc_1_cidr
  vpc_2_cidr = var.vpc_2_cidr

  vpc_1_route_table_id = module.vpc_1.public_route_table_id
  vpc_2_route_table_id = module.vpc_2.public_route_table_id
}

# ============================================================
# Terraform-managed SSH Key Pair
# ============================================================

module "key_pair" {
  source = "./modules/key-pair"

  key_name = var.bastion_key_name
}

# ============================================================
# Bastion-1
#
# Bastion-1 has NO ICMP ingress permission from VPC-2.
# Therefore Bastion-2 cannot initiate a ping to Bastion-1.
# ============================================================

module "bastion_1" {
  source = "./modules/bastion"

  name          = "bastion-1"
  vpc_id        = module.vpc_1.vpc_id
  subnet_id     = module.vpc_1.public_subnet_id
  instance_type = var.instance_type

  key_name = module.key_pair.key_name

  allowed_ssh_cidr = var.allowed_ssh_cidr

  allowed_icmp_cidr = null
}

# ============================================================
# Bastion-2
#
# Bastion-2 allows ICMP originating from VPC-1.
# Therefore Bastion-1 can initiate a ping to Bastion-2.
# ============================================================

module "bastion_2" {
  source = "./modules/bastion"

  name          = "bastion-2"
  vpc_id        = module.vpc_2.vpc_id
  subnet_id     = module.vpc_2.public_subnet_id
  instance_type = var.instance_type

  key_name = module.key_pair.key_name

  allowed_ssh_cidr = var.allowed_ssh_cidr

  allowed_icmp_cidr = var.vpc_1_cidr
}
# ============================================================
# VPC
# ============================================================

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.name
  }
}

# ============================================================
# Internet Gateway
# ============================================================

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.name}-igw"
  }
}

# ============================================================
# Public Subnet
# ============================================================

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.name}-public-subnet"
    Type = "Public"
  }
}

# ============================================================
# Public Route Table
# ============================================================

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.name}-public-rt"
  }
}

resource "aws_route" "internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# ============================================================
# Network ACL
#
# The NACL provides subnet-level baseline filtering.
# One-way ICMP initiation is enforced through Security Groups.
# ============================================================

resource "aws_network_acl" "public" {
  vpc_id     = aws_vpc.this.id
  subnet_ids = [aws_subnet.public.id]

  tags = {
    Name = "${var.name}-public-nacl"
  }
}

resource "aws_network_acl_rule" "allow_all_ingress" {
  network_acl_id = aws_network_acl.public.id

  rule_number = 100
  egress      = false
  protocol    = "-1"
  rule_action = "allow"
  cidr_block  = "0.0.0.0/0"
}

resource "aws_network_acl_rule" "allow_all_egress" {
  network_acl_id = aws_network_acl.public.id

  rule_number = 100
  egress      = true
  protocol    = "-1"
  rule_action = "allow"
  cidr_block  = "0.0.0.0/0"
}
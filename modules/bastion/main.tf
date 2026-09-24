# ============================================================
# Latest Amazon Linux 2023 AMI
# ============================================================

data "aws_ssm_parameter" "amazon_linux_2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

# ============================================================
# Security Group
# ============================================================

resource "aws_security_group" "this" {
  name        = "${var.name}-sg"
  description = "Security group for ${var.name}"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.name}-sg"
  }
}

# ============================================================
# SSH Ingress
# ============================================================

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.this.id

  description = "Allow SSH from administrator public IP"

  cidr_ipv4   = var.allowed_ssh_cidr
  from_port   = 22
  to_port     = 22
  ip_protocol = "tcp"
}

# ============================================================
# ICMP Ingress
#
# Created only when allowed_icmp_cidr is provided.
# Bastion-1 -> null       -> no ICMP ingress
# Bastion-2 -> 10.1/16    -> accepts ICMP from VPC-1
# ============================================================

resource "aws_vpc_security_group_ingress_rule" "icmp" {
  count = var.allowed_icmp_cidr != null ? 1 : 0

  security_group_id = aws_security_group.this.id

  description = "Allow ICMP from approved source"

  cidr_ipv4   = var.allowed_icmp_cidr
  ip_protocol = "icmp"
  from_port   = -1
  to_port     = -1
}

# ============================================================
# Outbound
# ============================================================

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.this.id

  description = "Allow all outbound traffic"

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}

# ============================================================
# EC2 Bastion
# ============================================================

resource "aws_instance" "this" {
  ami           = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  vpc_security_group_ids = [
    aws_security_group.this.id
  ]

  key_name = var.key_name

  associate_public_ip_address = true

  # Require IMDSv2
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  # Encrypted root disk
  root_block_device {
    encrypted   = true
    volume_type = "gp3"
    volume_size = 8
  }

  tags = {
    Name = var.name
  }
}
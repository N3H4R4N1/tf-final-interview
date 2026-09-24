# ============================================================
# Same-region VPC Peering
# ============================================================

resource "aws_vpc_peering_connection" "this" {
  vpc_id      = var.vpc_1_id
  peer_vpc_id = var.vpc_2_id
  auto_accept = true

  tags = {
    Name = var.name
  }
}

# ============================================================
# VPC-1 -> VPC-2 Route
# ============================================================

resource "aws_route" "vpc_1_to_vpc_2" {
  route_table_id            = var.vpc_1_route_table_id
  destination_cidr_block    = var.vpc_2_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}

# ============================================================
# VPC-2 -> VPC-1 Route
# ============================================================

resource "aws_route" "vpc_2_to_vpc_1" {
  route_table_id            = var.vpc_2_route_table_id
  destination_cidr_block    = var.vpc_1_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
}
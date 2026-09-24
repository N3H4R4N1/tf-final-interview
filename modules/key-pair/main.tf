# ============================================================
# Generate RSA Private/Public Key Pair
# ============================================================

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# ============================================================
# Register Public Key with AWS EC2
# ============================================================

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = tls_private_key.this.public_key_openssh

  tags = {
    Name = var.key_name
  }
}

# ============================================================
# Store Private Key Locally
#
# This file is ignored by Git.
# ============================================================

resource "local_sensitive_file" "private_key" {
  content         = tls_private_key.this.private_key_pem
  filename        = "${path.root}/${var.key_name}.pem"
  file_permission = "0400"
}
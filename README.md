# AWS VPC Peering & Bastion Connectivity

## Overview

This project provisions two AWS VPCs and establishes private connectivity between them using AWS VPC Peering.

All AWS infrastructure and network configurations are provisioned using Terraform.

No manual AWS Console resource configuration is required.

## Requirements

The solution implements:

- VPC-1: `10.1.0.0/16`
- VPC-2: `10.2.0.0/16`
- Public subnet in each VPC
- Bastion EC2 instance in each VPC
- Internet Gateway in each VPC
- Route table in each VPC
- VPC Peering between VPC-1 and VPC-2
- Terraform-managed Security Groups
- Terraform-managed Network ACLs
- Terraform-managed EC2 Key Pair
- Bastion-1 can initiate ICMP traffic to Bastion-2
- Bastion-2 cannot initiate ICMP traffic to Bastion-1

## Architecture

AWS Region:

`ap-south-1`

### VPC-1

- CIDR: `10.1.0.0/16`
- Public Subnet: `10.1.1.0/24`
- Availability Zone: `ap-south-1a`
- EC2: `bastion-1`

### VPC-2

- CIDR: `10.2.0.0/16`
- Public Subnet: `10.2.1.0/24`
- Availability Zone: `ap-south-1b`
- EC2: `bastion-2`

## VPC Peering

A same-region VPC Peering Connection provides private communication between both VPCs.

VPC-1 route:

```text
10.2.0.0/16 -> VPC Peering Connection
```

VPC-2 route:

```text
10.1.0.0/16 -> VPC Peering Connection
```

## Security Design

Security Groups are used to enforce the asymmetric ICMP requirement.

### Bastion-1

Ingress:

- SSH TCP/22 from administrator public IP
- No ICMP ingress permission from VPC-2

Egress:

- All outbound traffic

### Bastion-2

Ingress:

- SSH TCP/22 from administrator public IP
- ICMP from `10.1.0.0/16`

Egress:

- All outbound traffic

Therefore:

```text
Bastion-1 ---- ICMP ----> Bastion-2
             ALLOWED

Bastion-2 ---- ICMP ----> Bastion-1
             BLOCKED
```

AWS Security Groups are stateful.

Therefore, when Bastion-1 initiates an allowed ping to Bastion-2, the reply traffic is automatically permitted.

This does not allow Bastion-2 to initiate a new ICMP session toward Bastion-1.

## Network ACL Design

A custom Network ACL is created for each public subnet through Terraform.

The NACL provides subnet-level baseline connectivity.

The asymmetric ICMP requirement is enforced using Security Groups because Security Groups are stateful, whereas Network ACLs are stateless and require explicit request and response rules.

## SSH Key Management

Terraform generates an RSA 4096-bit SSH key pair.

The public key is registered as an AWS EC2 Key Pair.

The private key is stored locally as:

```text
vpc-peering-bastion-key.pem
```

The private key is excluded from Git using `.gitignore`.

The Terraform state also contains sensitive key material and must therefore be protected.

## Security Features

The solution includes:

- Restricted SSH source CIDR
- IMDSv2 enforcement
- Encrypted EC2 root volumes
- Terraform-managed network controls
- Private VPC-to-VPC communication through VPC Peering
- No private keys committed to Git

## Prerequisites

- AWS account
- AWS CLI
- Terraform >= 1.6
- Valid AWS credentials

Verify AWS access:

```bash
aws sts get-caller-identity
```

## Configuration

Create the real variable file:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Update:

```hcl
allowed_ssh_cidr = "YOUR_PUBLIC_IP/32"
```

For example:

```hcl
allowed_ssh_cidr = "49.36.100.20/32"
```

## Deployment

Format:

```bash
terraform fmt -recursive
```

Initialize:

```bash
terraform init
```

Validate:

```bash
terraform validate
```

Plan:

```bash
terraform plan
```

Apply:

```bash
terraform apply
```

## Terraform Outputs

Run:

```bash
terraform output
```

This provides resource information including:

- VPC IDs
- VPC ARNs
- Subnet IDs
- Internet Gateway IDs
- Route Table IDs
- NACL IDs
- VPC Peering Connection ID
- Key Pair ID/ARN
- EC2 IDs/ARNs
- Public IP addresses
- Private IP addresses
- Security Group IDs/ARNs

## Connectivity Validation

### Bastion-1 -> Bastion-2

Get the Bastion-1 public IP:

```bash
terraform output -raw bastion_1_public_ip
```

Get the Bastion-2 private IP:

```bash
terraform output -raw bastion_2_private_ip
```

SSH to Bastion-1:

```bash
ssh -i vpc-peering-bastion-key.pem ec2-user@<BASTION_1_PUBLIC_IP>
```

Run:

```bash
ping -c 4 <BASTION_2_PRIVATE_IP>
```

Expected result:

```text
PASS
```

Bastion-1 should successfully ping Bastion-2.

### Bastion-2 -> Bastion-1

Get Bastion-2 public IP:

```bash
terraform output -raw bastion_2_public_ip
```

Get Bastion-1 private IP:

```bash
terraform output -raw bastion_1_private_ip
```

SSH to Bastion-2:

```bash
ssh -i vpc-peering-bastion-key.pem ec2-user@<BASTION_2_PUBLIC_IP>
```

Run:

```bash
ping -c 4 <BASTION_1_PRIVATE_IP>
```

Expected result:

```text
BLOCKED
```

Bastion-2 should not be able to initiate ICMP communication with Bastion-1.

## Resource Inventory

The Excel inventory is maintained under:

```text
inventory/aws-resource-inventory.xlsx
```

It contains:

1. Resource Inventory
2. Security Rules
3. Route Tables

Actual AWS resource IDs and ARNs should be populated after deployment using Terraform outputs and AWS resource information.

## Architecture Diagram

The draw.io architecture diagram is maintained under:

```text
diagrams/architecture.drawio
```

A PNG export is maintained as:

```text
diagrams/architecture.png
```

## Cleanup

Destroy the infrastructure after validation:

```bash
terraform destroy
```

Confirm:

```text
yes
```

## Important

Do not commit:

- `terraform.tfvars`
- Terraform state files
- `.pem` private keys
- Terraform plan files

All AWS resources and network configurations in this project are provisioned using Terraform.
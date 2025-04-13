# Terraform Module: AWS VPC with Public and Private Subnets

This Terraform module creates a
Virtual Private Cloud (VPC) in AWS with the necessary resources for a basic network setup.
It includes public and private subnets, an internet gateway (IGW), a NAT gateway, and associated route tables.

## Description

This module provisions a VPC with:

- A custom CIDR block for the VPC.
- Public and private subnets in specified availability zones (AZs).
- An internet gateway (IGW) attached to the VPC.
- Route tables for public and private subnets.
- A NAT gateway with an Elastic IP (EIP) in the public subnet, allowing private subnets to access the internet.

## Usage Example

Example of using the module in a Terraform project:

```hcl
module "main_vpc" {
  source = "github.com/EdgarHarutyunyan2025/Terraform_modules//modules/vpc"

  vpc_cidr               = "10.0.0.0/16"
  vpc_name               = "my-vpc"
  public_subnet_cidrs    = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs   = ["10.0.3.0/24", "10.0.4.0/24"]
  main_availability_zone  = ["us-east-1a", "us-east-1b"]
  az_index               = 0
}


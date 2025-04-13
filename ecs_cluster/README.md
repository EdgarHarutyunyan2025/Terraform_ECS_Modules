# Terraform ECS Cluster for Fargate

This Terraform configuration module is used to create an **Amazon ECS Cluster** for running containerized applications on AWS **Fargate**.

## Requirements

- **Terraform**: v0.12 or later
- **AWS Account**: Valid AWS credentials with sufficient IAM permissions to create ECS resources.
  
## Resource

This module creates the following resource:

- **ECS Cluster**: A container management service to manage your containerized applications.

## Variables

- `cluser_name`: The name of the ECS cluster (e.g., `"fargate-cluster"`).

## Usage

### Example Configuration

```hcl
module "ecs_cluster" {
  source       = "./path-to-module"
  cluser_name  = "my-fargate-cluster"
}


# ECS Fargate IAM Role and Policies for S3, ECR, and CloudWatch

This Terraform configuration creates an IAM role for ECS Fargate tasks and attaches the necessary policies to allow access to Amazon S3, ECR, and CloudWatch. The role provides ECS tasks with read/write access to all S3 buckets, ECR image access, and CloudWatch logging capabilities.

## Requirements

- **Terraform**: v0.12 or later
- **AWS Account**: Ensure valid AWS credentials are configured and have the necessary permissions to create IAM roles and policies.

## Resources Created

This module creates the following AWS resources:

- **IAM Role (`s3-read-write`)**: An IAM role that ECS Fargate tasks can assume.
- **IAM Policies**:
  - **`ecs_fargate_s3_policy`**: Grants permissions to ECS tasks for interacting with S3.
  - **`ecs_fargate_ecr_policy`**: Grants permissions to ECS tasks for interacting with ECR.
  - **`ecs_cloudwatch_policy`**: Grants permissions to ECS tasks to send logs to CloudWatch.
- **IAM Role Policy Attachments**: These attach the IAM policies to the ECS role to ensure ECS tasks have the required permissions.

## Variables

| Variable               | Description                                                | Type       | Default          |
|------------------------|------------------------------------------------------------|------------|------------------|
| `log_name`             | The name of the CloudWatch log group for ECS logs.         | `string`   | `"ecs-logs"`     |

## Usage

### Example Configuration

```hcl
module "ecs_fargate_iam" {
  source = "./path-to-module"

  log_name = "my-ecs-log-group"
}


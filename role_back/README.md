# ECS IAM Role and Policy for DynamoDB, ECR, and CloudWatch Access

This Terraform configuration creates an IAM role for ECS tasks with attached policies for accessing DynamoDB, ECR, and CloudWatch. This allows ECS tasks to interact with DynamoDB for data operations, pull container images from ECR, and push logs to CloudWatch.

## Requirements

- **Terraform**: v0.12 or later
- **AWS Account**: Ensure valid AWS credentials are configured and have the necessary permissions to create IAM roles and policies.

## Resources Created

This module creates the following AWS resources:

- **IAM Role (`ecs_task_dynamo_role`)**: An IAM role that ECS tasks can assume.
- **IAM Policies**:
  - **`ecs_dynamodb_policy`**: Policy allowing ECS tasks to interact with DynamoDB.
  - **`ecs_ecr_policy`**: Policy allowing ECS tasks to pull images from ECR.
  - **`ecs_cloudwatch_policy_back`**: Policy allowing ECS tasks to send logs to CloudWatch.
- **IAM Role Policy Attachments**: These attach the IAM policies to the ECS role.

## Variables

| Variable                | Description                                         | Type       | Default          |
|-------------------------|-----------------------------------------------------|------------|------------------|
| `dynamo_db_arn`         | ARN of the DynamoDB table(s) that ECS tasks can access. | `string`   | `"arn:aws:dynamodb:region:account-id:table/table-name"` |
| `log_name`              | The name of the CloudWatch log group for ECS logs.  | `string`   | `"ecs-logs"`     |
| `region`                | The AWS region to be used for the resources.        | `string`   | `"us-east-1"`    |

## Usage

### Example Configuration

```hcl
module "ecs_iam_role" {
  source = "./path-to-module"

  dynamo_db_arn = "arn:aws:dynamodb:us-east-1:123456789012:table/my-dynamodb-table"
  log_name      = "my-ecs-log-group"
}


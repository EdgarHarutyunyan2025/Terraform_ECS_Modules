# DynamoDB Table with Global Secondary Index Terraform Module

This module creates an AWS DynamoDB table with a global secondary index (GSI) for efficient querying based on the `data` attribute.

## Resources Created

1. **aws_dynamodb_table**: A DynamoDB table with:
   - Primary key (`id` of type string).
   - Global Secondary Index (`DataIndex` on the `data` attribute).
   - **Pay-per-request** billing mode for flexible scaling based on usage.

## Input Variables

| Name             
|------------------
| name
| hash_key
| attributes
| billing_mode

## Example Usage

```hcl
module "dynamodb_table" {
  source = "./modules/dynamodb_table"
  
  name     = "my-table"
  hash_key = "id"
  
  attributes = [
    { name = "id", type = "S" },
    { name = "data", type = "S" }
  ]

  billing_mode = "PAY_PER_REQUEST"
}


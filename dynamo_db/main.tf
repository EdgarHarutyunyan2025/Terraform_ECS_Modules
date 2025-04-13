resource "aws_dynamodb_table" "my_table" {
  name     = "my-table"
  hash_key = "id"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "data"
    type = "S"
  }

  billing_mode = "PAY_PER_REQUEST"

  global_secondary_index {
    name            = "DataIndex"
    hash_key        = "data"
    projection_type = "ALL"
  }
}


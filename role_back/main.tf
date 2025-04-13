resource "aws_iam_role" "ecs_task_dynamo_role" {
  name = "ecs-task-dynamo-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "ecs_dynamodb_policy" {
  name        = "ecs-dynamodb-policy"
  description = "Policy that allows ECS tasks to access DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:BatchWriteItem",
          "dynamodb:GetItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Effect   = "Allow"
        Resource = var.dynamo_db_arn
      }
    ]
  })
}

resource "aws_iam_policy" "ecs_ecr_policy" {
  name        = "ecs-ecr-policy"
  description = "Policy to allow ECS tasks to access ECR"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "ecs_cloudwatch_policy_back" {
  name        = "ecs-cloudwatch-policy_back"
  description = "Policy to allow ECS tasks to send logs to CloudWatch"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:eu-central-1:877680973630:log-group:${var.log_name}:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_dynamodb_policy_attachment" {
  role       = aws_iam_role.ecs_task_dynamo_role.name
  policy_arn = aws_iam_policy.ecs_dynamodb_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs_task_ecr_policy_attachment" {
  role       = aws_iam_role.ecs_task_dynamo_role.name
  policy_arn = aws_iam_policy.ecs_ecr_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs_task_cloudwatch_policy_attachment" {
  role       = aws_iam_role.ecs_task_dynamo_role.name
  policy_arn = aws_iam_policy.ecs_cloudwatch_policy_back.arn
}

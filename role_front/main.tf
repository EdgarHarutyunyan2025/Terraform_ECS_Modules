resource "aws_iam_role" "s3-read-write" {
  name = "ecs-fargate-task-role-s3"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_policy" "ecs_fargate_s3_policy" {
  name        = "ecs-fargate-s3-policy"
  description = "Policy granting read-write access to all S3 buckets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "arn:aws:s3:::*",
          "arn:aws:s3:::*/*"
        ]
        Effect = "Allow"
      }
    ]
  })
}

resource "aws_iam_policy" "ecs_fargate_ecr_policy" {
  name        = "ecs-fargate-ecr-policy"
  description = "Policy granting access to ECR for ECS Fargate"

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
        Resource = "*"
        Effect   = "Allow"
      }
    ]
  })
}

resource "aws_iam_policy" "ecs_cloudwatch_policy" {
  name        = "ecs-cloudwatch-policy"
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
        Effect = "Allow"
        Resource = [
          "arn:aws:logs:eu-central-1:877680973630:log-group:${var.log_name}:*",
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_cloudwatch_policy_attachment" {
  role       = aws_iam_role.s3-read-write.name
  policy_arn = aws_iam_policy.ecs_cloudwatch_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs_fargate_task_policy_attachment" {
  role       = aws_iam_role.s3-read-write.name
  policy_arn = aws_iam_policy.ecs_fargate_s3_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs_fargate_ecr_policy_attachment" {
  role       = aws_iam_role.s3-read-write.name
  policy_arn = aws_iam_policy.ecs_fargate_ecr_policy.arn
}

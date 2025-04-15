resource "aws_ecr_repository" "main_image" {
  name         = var.ecr_name
  force_delete = true
}

resource "null_resource" "docker_login" {
  provisioner "local-exec" {
    command = "aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${aws_ecr_repository.main_image.repository_url}"
  }

  depends_on = [aws_ecr_repository.main_image]
}

resource "null_resource" "docker_push" {
  provisioner "local-exec" {
    command = <<EOT
      docker tag ${var.docker-image} ${aws_ecr_repository.main_image.repository_url}:latest
      docker push ${aws_ecr_repository.main_image.repository_url}:latest
    EOT
  }

  depends_on = [null_resource.docker_login]
}

resource "aws_ecr_lifecycle_policy" "clean_old_images" {
  repository = aws_ecr_repository.main_image.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = var.lifecycle_description
        selection = {
          tagStatus   = var.lifecycle_tag_status # "untagged"
          countType   = var.lifecycle_count_type # "sinceImagePushed"
          countUnit   = "days"
          countNumber = var.lifecycle_count_number # 1
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}


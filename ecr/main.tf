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


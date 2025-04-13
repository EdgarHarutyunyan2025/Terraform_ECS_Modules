Terraform AWS ECR and Docker Integration
This Terraform configuration automates the creation of an Amazon Elastic Container Registry (ECR) repository,
logs into Docker, and pushes a Docker image to the ECR repository.

Requirements
Terraform: v0.12 or later

AWS CLI: Installed and configured with valid credentials

Docker: Installed on the local machine

AWS Account: Proper IAM permissions to create ECR repositories and interact with Docker

Resources
This module creates the following resources:

AWS ECR Repository: A repository in Amazon ECR to store Docker images.

Docker Login: Logs into AWS ECR using the AWS CLI.

Docker Push: Tags and pushes a Docker image to the ECR repository.

Usage
Variables
ecr_name: The name of the ECR repository (e.g., "my-docker-repo").

region: The AWS region in which the repository will be created (e.g., "us-east-1").

docker-image: The Docker image to be pushed (e.g., "my-app-image").


Example Configuration

#--------------------------------

module "docker_ecr" {
  source    = "./path-to-module"
  ecr_name  = "my-docker-repo"
  region    = "us-east-1"
  docker-image = "my-app-image"
}

# ECS Task Definition for Fargate Service

This Terraform module defines an ECS Task Definition for running containerized applications on AWS ECS using Fargate or EC2 instances. The configuration specifies the required resources, network configuration, container definition, and logging setup.

## Requirements

- **Terraform**: v0.12 or later
- **AWS Account**: Ensure that valid AWS credentials are set up with permissions to create ECS resources.

## Resources Created

- **ECS Task Definition**: Defines the task to be run in ECS, including container images, CPU and memory requirements, port mappings, and log configuration.

## Variables

| Variable                | Description                                                   | Type     | Default        |
|-------------------------|---------------------------------------------------------------|----------|----------------|
| `family`                | The family name of the ECS task definition.                   | `string` | `my-family`    |
| `network_mode`          | The network mode for the ECS task (e.g., `awsvpc`, `bridge`). | `string` | `awsvpc`       |
| `requires_compatibilities` | Specifies the launch type (e.g., `FARGATE`, `EC2`).          | `string` | `FARGATE`      |
| `cpu`                   | The number of CPU units for the task.                         | `string` | `256`          |
| `memory`                | The memory (in MiB) for the task.                             | `string` | `512`          |
| `execution_role_arn`    | The IAM role ARN for ECS to execute the task.                 | `string` | `""`           |
| `task_role_arn`         | The IAM role ARN for the task to interact with AWS services. | `string` | `""`           |
| `container_name`        | The name of the container in the ECS task.                    | `string` | `my-container` |
| `container_image`       | The image URL for the container (e.g., ECR or Docker Hub).    | `string` | `""`           |
| `container_cpu`         | The CPU units for the container.                              | `string` | `256`          |
| `container_memory`      | The memory (in MiB) for the container.                        | `string` | `512`          |
| `essential`             | Whether the container is essential for the task.              | `bool`   | `true`         |
| `task_command`          | Command to run inside the container.                          | `string` | `""`           |
| `container_port`        | The port on which the container listens.                      | `string` | `80`           |
| `log_name`              | The CloudWatch log group for container logs.                  | `string` | `ecs-logs`     |

## Usage

```hcl
module "ecs_task_definition" {
  source = "./path-to-module"

  family                    = "my-ecs-task-family"
  network_mode              = "awsvpc"
  requires_compatibilities  = "FARGATE"
  cpu                       = "256"
  memory                    = "512"
  execution_role_arn        = "arn:aws:iam::123456789012:role/my-execution-role"
  task_role_arn             = "arn:aws:iam::123456789012:role/my-task-role"
  container_name            = "my-container"
  container_image           = "my-repo/my-image:latest"
  container_cpu             = "256"
  container_memory          = "512"
  essential                 = true
  task_command              = "start.sh"
  container_port            = "80"
  log_name                  = "ecs-task-logs"
}


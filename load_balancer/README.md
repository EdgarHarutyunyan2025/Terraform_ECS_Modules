# Terraform ECS Service for Fargate

This Terraform configuration module is used to create an **Amazon ECS Service** for running containerized applications on AWS **Fargate**. The service will be deployed in the specified ECS cluster, using the provided task definition and load balancer.

## Requirements

- **Terraform**: v0.12 or later
- **AWS Account**: Valid AWS credentials with sufficient IAM permissions to create ECS and related resources.
  
## Resource

This module creates the following resource:

- **ECS Service**: A service that runs and maintains the desired number of ECS tasks.

## Variables

The following variables must be provided:

- `service_name`: The name of the ECS service.
- `cluster_id`: The ECS cluster ID where the service will run.
- `task_definition_id`: The task definition ARN or ID that defines which Docker image and configuration to use.
- `launch_type`: The launch type of the service (e.g., `FARGATE` or `EC2`).
- `service_subnets`: The subnets to launch the service in.
- `service_security_groups`: The security groups to attach to the service.
- `target_group_arn`: The ARN of the target group to associate with the load balancer.
- `container_name`: The container name that the load balancer will target.
- `container_port`: The container port to forward traffic to.

## Usage

### Example Configuration

```hcl
module "ecs_service" {
  source               = "./path-to-module"
  service_name         = "front-service"
  cluster_id           = "your-cluster-id"
  task_definition_id   = "your-task-definition-id"
  launch_type          = "FARGATE"
  service_subnets      = ["subnet-12345", "subnet-67890"]
  service_security_groups = ["sg-12345"]
  target_group_arn     = "your-target-group-arn"
  container_name       = "front-container"
  container_port       = 80
}


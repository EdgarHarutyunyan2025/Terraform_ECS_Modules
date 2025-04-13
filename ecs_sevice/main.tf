resource "aws_ecs_service" "front" {
  name            = var.service_name
  cluster         = var.cluster_id
  task_definition = var.task_definition_id
  desired_count   = 1

  launch_type = var.launch_type

  network_configuration {
    subnets          = var.service_subnets
    security_groups  = var.service_security_groups
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}

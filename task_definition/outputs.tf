output "task_definition_arn" {
  value = aws_ecs_task_definition.my_task.arn
}

output "task_definition_id" {
  value = aws_ecs_task_definition.my_task.id
}

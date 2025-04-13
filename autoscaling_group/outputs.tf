output "ecs_target_id" {
  value = aws_appautoscaling_target.ecs_target.id
}

output "ecs_policy_id" {
  value = aws_appautoscaling_policy.ecs_policy.id
}

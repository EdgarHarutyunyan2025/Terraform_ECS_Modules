output "ecs_cluster_id" {
  value = aws_ecs_cluster.fargate_cluster.id
}


output "ecs_cluster_name" {
  value = aws_ecs_cluster.fargate_cluster.name
}

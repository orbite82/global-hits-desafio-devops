output "ecs_cluster_id" {
  value = aws_ecs_cluster.devops.id
}

output "ecs_service_id" {
  value = aws_ecs_service.devops.id
}

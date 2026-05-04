output "ecr" {
  value = aws_ecr_repository.main
}

output "ecs_cluster" {
  value = aws_ecs_cluster.main
}

output "ecs_service" {
  value = aws_ecs_service.app
}

output "ecs_task_definition" {
  value = aws_ecs_task_definition.app
}

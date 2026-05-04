output "ecr_repository" {
  value = module.app.ecr.name
}

output "ecs_cluster_name" {
  value = module.app.ecs_cluster.name
}

output "ecs_service_name" {
  value = module.app.ecs_service.name
}

output "ecs_task_definition_family" {
  value = module.app.ecs_task_definition.family
}

# ECS Service Outputs
output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = module.ecs_service_bot.ecs_service_name
}

# ALB Outputs
output "alb_target_group_arn" {
  description = "ARN of the ALB target group"
  value       = module.ecs_service_bot.alb_target_group_arn
}

# Route53 Outputs
output "application_domain_name" {
  description = "The domain name of the service bot application"
  value       = module.ecs_service_bot.application_domain_name
}

# IAM Outputs
output "task_role_arn" {
  description = "ARN of the ECS task role"
  value       = module.ecs_service_bot.task_role_arn
}

# Container Definitions
output "container_definitions" {
  description = "The container definitions"
  value       = module.ecs_service_bot.container_definitions
}

output "additional_container_definitions" {
  description = "The additional container definitions"
  value       = module.ecs_service_bot.additional_container_definitions
}

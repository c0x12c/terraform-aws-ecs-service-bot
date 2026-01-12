module "ecs_service_bot" {
  source  = "c0x12c/ecs-application/aws"
  version = "1.2.1"

  name        = var.service_name
  environment = var.environment
  region      = var.region

  # ECS Configuration
  ecs_cluster_id   = var.ecs_cluster_id
  ecs_cluster_name = var.ecs_cluster_name
  vpc_id           = var.vpc_id
  subnet_ids       = var.subnet_ids

  # Task Configuration
  task_cpu               = var.task_cpu
  task_memory            = var.task_memory
  container_cpu          = var.container_cpu
  container_memory       = var.container_memory
  container_port         = var.container_port
  container_image        = var.service_bot_image
  service_desired_count  = var.service_desired_count
  service_max_capacity   = var.service_max_capacity
  enable_autoscaling     = var.enable_autoscaling
  enable_execute_command = var.enable_execute_command
  health_check_path      = var.health_check_path
  health_check_enabled   = var.health_check_enabled
  force_new_deployment   = var.force_new_deployment
  assign_public_ip       = var.assign_public_ip

  # IAM
  ecs_execution_policy_arns  = var.ecs_execution_policy_arns
  additional_iam_policy_arns = var.additional_iam_policy_arns

  # ALB & Route53
  alb_dns_name                  = var.alb_dns_name
  alb_security_groups           = var.alb_security_groups
  aws_lb_listener_arn           = var.aws_lb_listener_arn
  aws_lb_listener_rule_priority = var.aws_lb_listener_rule_priority
  alb_zone_id                   = var.alb_zone_id
  dns_name                      = var.dns_name
  route53_zone_id               = var.route53_zone_id

  # Environment Variables (equivalent to Kubernetes ConfigMap)
  container_environment = concat([
    # Required environment variables
    {
      name  = "MICRONAUT_ENVIRONMENTS"
      value = var.environment
    },
    {
      name  = "HTTP_CLIENT_LOG_LEVEL"
      value = var.http_client_log_level
    },
    {
      name  = "APP_DOMAIN"
      value = var.app_domain
    },
    {
      name  = "SLACK_BOT_USER_ID"
      value = var.slack_bot_user_id
    },
    {
      name  = "ALLOWED_SLACK_CHANNEL"
      value = var.allowed_slack_channel
    },
    {
      name  = "ON_CALL_SLACK_CHANNEL"
      value = var.on_call_slack_channel
    },
    {
      name  = "SLACK_USER_GROUP_NAMES"
      value = var.slack_user_group_names
    },
    {
      name  = "SLACK_CHANNEL_PREFIX"
      value = var.slack_channel_prefix
    },
    {
      name  = "GITHUB_ORG"
      value = var.github_org
    },
    {
      name  = "GITHUB_REPO_LIST"
      value = join(",", concat(var.app_repo_list, var.infra_repo_list))
    },
    {
      name  = "APP_REPO_LIST"
      value = join(",", var.app_repo_list)
    },
    {
      name  = "INFRA_REPO_LIST"
      value = join(",", var.infra_repo_list)
    },
    # Optional environment variables
    {
      name  = "ATLASSIAN_HOST"
      value = var.atlassian_host
    },
    {
      name  = "JENKINS_USERNAME"
      value = var.jenkins_username
    },
    {
      name  = "JENKINS_HOST"
      value = var.jenkins_host
    },
    {
      name  = "JENKINS_REPOSITORY"
      value = var.jenkins_repository
    },
    {
      name  = "ATLASSIAN_USERNAME"
      value = var.atlassian_username
    },
    {
      name  = "ATLASSIAN_PAGE_PATH_PREFIX"
      value = var.atlassian_page_path_prefix
    },
    {
      name  = "SPACE_ID"
      value = var.space_id
    },
    {
      name  = "ON_CALL_PAGE_ID"
      value = var.on_call_page_id
    },
    {
      name  = "ON_CALL_TEMPLATE_PAGE_ID"
      value = var.on_call_template_page_id
    },
    {
      name  = "ON_CALL_PROCESS_PAGE_ID"
      value = var.on_call_process_page_id
    }
  ], var.additional_environment_variables)

  # Secrets (equivalent to Kubernetes Secrets)
  container_secrets = concat([
    # Required secrets
    {
      name      = "SLACK_SIGNING_SECRET"
      valueFrom = var.slack_signing_secret_arn
    },
    {
      name      = "SLACK_BOT_TOKEN"
      valueFrom = var.slack_bot_token_arn
    },
    {
      name      = "SLACK_USER_TOKEN"
      valueFrom = var.slack_user_token_arn
    },
    {
      name      = "GITHUB_APP_ID"
      valueFrom = var.github_app_id_arn
    },
    {
      name      = "GITHUB_APP_INSTALLATION_ID"
      valueFrom = var.github_app_installation_id_arn
    },
    {
      name      = "GITHUB_APP_PRIVATE_KEY"
      valueFrom = var.github_app_private_key_arn
    },
    # Optional secrets
    {
      name      = "JENKINS_API_TOKEN"
      valueFrom = var.jenkins_api_token_arn
    },
    {
      name      = "ATLASSIAN_API_TOKEN"
      valueFrom = var.atlassian_api_token_arn
    }
  ], var.additional_secret_arns)

  # Notification
  enabled_notification                = var.enabled_notification
  slack_webhook_url                   = var.slack_webhook_url
  notification_deployment_event_types = var.notification_deployment_event_types
  notification_service_event_types    = var.notification_service_event_types
  notification_task_stop_codes        = var.notification_task_stop_codes

  launch_type = var.launch_type
}

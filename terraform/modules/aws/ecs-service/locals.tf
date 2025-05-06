locals {
  identify_cluster  = lookup({ prd = "prd", stg = "stg", dev = "dev" }, var.env_name, "dev")
  domain_name       = lookup({ prd = "xxxxxx.com.br", stag = "devxxxxxx.com.br" }, var.env_name, "devxxxxxx.com.br")
  app_environment   = lookup({ prd = "prd", stg = "staging" }, var.env_name, "development")
  environment_type  = lookup({ prd = "prd", stg = "stg" }, var.env_name, "dev")
  is_prod           = local.environment_type == "prd" ? true : false
  is_dev            = local.environment_type == "dev" ? true : false
  subnet_white_list = concat(var.private_subnets, var.vpn_subnet_white_list)
  get_secret_arns   = [for secret in var.secrets : secret.valueFrom]
  get_s3_arns   = [for bucket in var.bucket : bucket.valueFrom]
  container_list = {
    app_name        = var.project_name,
    env_name        = var.env_name,
    container_cpu   = var.container_cpu,
    container_mem   = var.container_mem,
    container_port  = var.container_port,
    container_health= var.container_health,
    ecr_repo        = aws_ecr_repository.aws-ecr.repository_url,
    ecr_tag         = var.ecr_tag
    log_group_id    = aws_cloudwatch_log_group.log-group.id,
    aws_region      = var.aws_region,
    app_environment = local.app_environment
  }
  env_list = {
    environment = jsonencode(var.environments)
    secrets     = jsonencode(var.secrets)
  }
}
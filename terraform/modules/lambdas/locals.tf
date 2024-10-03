locals {
  get_name         = var.app_name
  environment_type = lookup({ prd = "prd", stg = "stg" }, var.env_name, "dev")
  app_environment  = lookup({ prd = "prd", stg = "staging" }, var.env_name, "development")
}

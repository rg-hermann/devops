locals {
  stage_name  = lookup({ prd = "prd", stg = "qa" }, var.env_name, "dev")
}
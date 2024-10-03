module "alb_internal" {
  source                = "../alb"
  alb_name              = "${var.module_name}-"
  internal              = var.internal_alb
  balancer_type         = "network"
  vpc_id                = var.vpc_id
  application_port      = var.container_port
  certificate_arn       = var.certificate_arn
  enable_deletion_protection   = true
  project_name          = var.project_name
  private_subnet_ids    = var.internal_alb ? var.private_subnet_ids : var.public_subnet_ids
  tags                  = var.tags
  additional_ssl_ports  = var.additional_ssl_ports
  target_groups         = var.target_groups
}
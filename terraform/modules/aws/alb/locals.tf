locals {
  listener_rules = [ for target in var.target_groups : target if length(target.block_paths) > 0 ]
  get_listener_ports = concat([ for target in var.target_groups : target.listener_port ],var.additional_ssl_ports)
  is_tcp = var.balancer_type == "network" ? true : false
  get_listener_rules = local.is_tcp ? [] : local.listener_rules
}
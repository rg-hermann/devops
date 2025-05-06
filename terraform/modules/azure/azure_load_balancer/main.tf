resource "azurerm_public_ip" "this" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = var.ip_sku
  domain_name_label   = var.domain_name_label
  tags                = var.tags
}

resource "azurerm_lb" "this" {
  name                = var.lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.lb_sku
  frontend_ip_configuration {
    name                 = "LoadBalancerFrontEnd"
    public_ip_address_id = azurerm_public_ip.this.id
  }
  tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "backend" {
  name            = var.backend_pool_name
  loadbalancer_id = azurerm_lb.this.id
  tags            = var.tags
}

resource "azurerm_lb_probe" "probe" {
  name                = var.probe_name
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.this.id
  protocol            = var.probe_protocol
  port                = var.probe_port
  interval_in_seconds = var.probe_interval
  number_of_probes    = var.probe_count
}

resource "azurerm_lb_rule" "lb_rule" {
  name                           = var.lb_rule_name
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.this.id
  protocol                       = var.rule_protocol
  frontend_port                  = var.frontend_port
  backend_port                   = var.backend_port
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.backend.id
  probe_id                       = azurerm_lb_probe.probe.id
  enable_floating_ip             = var.enable_floating_ip
  idle_timeout_in_minutes        = var.idle_timeout
}

resource "azurerm_lb_nat_rule" "nat_rule" {
  count                          = var.create_nat_rule ? 1 : 0
  name                           = var.nat_rule_name
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.this.id
  protocol                       = "Tcp"
  frontend_port                  = var.nat_frontend_port
  backend_port                   = var.nat_backend_port
  frontend_ip_configuration_name = "LoadBalancerFrontEnd"
  idle_timeout_in_minutes        = var.idle_timeout
}

output "lb_id" {
  description = "ID do Load Balancer criado"
  value       = azurerm_lb.this.id
}

output "public_ip_address" {
  description = "IP público atribuído ao Load Balancer"
  value       = azurerm_public_ip.this.ip_address
}

output "backend_pool_id" {
  description = "ID do backend address pool"
  value       = azurerm_lb_backend_address_pool.backend.id
}

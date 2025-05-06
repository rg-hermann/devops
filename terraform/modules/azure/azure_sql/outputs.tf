output "sql_server_id" {
  description = "ID do servidor SQL"
  value       = azurerm_sql_server.sql_server.id
}

output "sql_database_id" {
  description = "ID do banco de dados SQL"
  value       = azurerm_sql_database.sql_database.id
}

output "sql_server_fqdn" {
  description = "FQDN do servidor SQL"
  value       = azurerm_sql_server.sql_server.fully_qualified_domain_name
}

variable "sql_server_name" {
  description = "Nome do servidor SQL"
  type        = string
}

variable "sql_database_name" {
  description = "Nome do banco de dados SQL"
  type        = string
}

variable "resource_group_name" {
  description = "Nome do grupo de recursos"
  type        = string
}

variable "location" {
  description = "Localização do recurso"
  type        = string
}

variable "admin_username" {
  description = "Nome de usuário administrador do servidor SQL"
  type        = string
}

variable "admin_password" {
  description = "Senha do administrador do servidor SQL"
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "SKU do banco de dados SQL (exemplo: S0, S1, P1)"
  type        = string
}

variable "tags" {
  description = "Tags para os recursos"
  type        = map(string)
  default     = {}
}

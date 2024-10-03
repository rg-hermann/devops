variable "env_name" {
  description = "Nome que define o ambiente (dev, stg, prd)"
  type        = string
}
variable "app_name" {
  description = "Nome da aplicação"
  type        = string
}
variable "tags" {
  type        = map(string)
  description = "Tags adicionais para o recurso"
}
variable "module_name" {
  type = string
  description = "Nome do módulo"
}
variable "user_group_id" {
  type = string
  description = "ID do grupo de usuários do Redis"
}
variable "admin_user_id" {
  type = string
  description = "ID do usuário admin do Redis"
}
variable "admin_access_string" {
  type = string
  description = "CIDR para acesso ao Redis"
}
variable "engine" {
  type = string
  description = "Engine do Redis"
}
variable "node_type" {
  type = string
  description = "Tipo de instância do Redis"
}
variable "num_cache_nodes" {
  type = number
  default = 1
}
variable "engine_version" {
  type = string
  description = "Versão do Redis"
}
variable "port" {
  type = number
  default = 6379
}
variable "vpc_id" {
    type = string
    description = "ID da VPC"
}
variable "private_subnet_ids" {
  type = list(string)
  description = "Lista de IDs das subnets privadas"
}
variable "subnet_white_list" {
  type = list(string)
  description = "Lista de subnets que podem acessar o Redis"
}
variable "private_subnets" {
  type = list(string)
  description = "Lista de subnets privadas"
}
variable "aliases" {
  type = list(string)
  description = "Lista de aliases para o domínio principal"
}
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
variable "allowed_cors_domains" {
  type = list(string)
  description = "Lista de domínios permitidos para CORS"
}
variable "certificate_arn" {
  type = string
  description = "ARN do certificado SSL"
}
variable "origin_path" {
  type = string
  description = "Caminho do bucket S3"
  default = "/app"
}
variable "module_name" {
  type = string
  description = "Nome do módulo"
}
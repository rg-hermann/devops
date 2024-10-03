# === Environment ===
variable "project_name" {
  type        = string
  description = "Application Name"
}
variable "env_name" {
  type        = string
  description = "Application Environment"
}
variable "module_name" {
  type        = string
  description = "Module Name"
  default     = ""
}
variable "certificate_arn" {
  type        = string
  description = "Certificate ARN"
}
variable "gateway_url" {
  type        = string
  description = "Gateway URL"
}
variable "endpoints" {
  type        = list(map(string))
  description = "List of endpoints"
}
variable "target_internal" {
  type        = bool
  description = "Target internal"
  default     = false
}
# === COMMON ===
variable "tags" {
  type = map(string)
  default = {}
  description = "Tags to apply to all resources"
}
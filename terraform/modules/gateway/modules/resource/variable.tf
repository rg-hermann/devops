variable "root_resource_id" {
  type = string
  description = "The ID of the root resource of the organization"
}
variable "rest_api_id" {
  type = string
}
variable "proxy_url" {
  type = string
}
variable "endpoint" {
  type = string
}
variable "vpc_link_id" {
  type = string
  default = ""
}
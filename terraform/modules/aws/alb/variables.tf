variable "project_name" {
    type = string
    description = "The name of the project"
}
variable "public_subnet_ids" {
    type = list(string)
    description = "The public subnet ids"
    default = []
}
variable "private_subnet_ids" {
    type = list(string)
    description = "The private subnet ids"
    default = []
}
variable "tags" {
    type = map(string)
    description = "The tags"
}
variable "application_port" {
    type = number
    description = "The application port"
}
variable "vpc_id" {
    type = string
    description = "The vpc id"
}
variable "target_groups" {
    type = list(any)
    description = "The list of target groups and listeners"
}
variable "certificate_arn" {
    type = string
    description = "The certificate arn"
    default = ""
}
variable "enable_deletion_protection" {
    type = bool
    description = "The enable deletion"
}
variable "internal" {
    type = bool
    description = "The internal"
    default = false
}
variable "alb_name" {
    type = string
    description = "The alb name"
    default = "-"
}
variable "balancer_type" {
    type = string
    description = "The balancer type"
    default = "application"
}
variable "additional_ssl_ports" {
    type = list(number)
    description = "The additional listener ports"
    default = []
}
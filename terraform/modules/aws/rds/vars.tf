variable "subnet_ids" {
  default = ""
  description = ""
}
variable "rds_username" {
  type = string
  default = "postgresql"
}
variable "rds_db_name" {
  type = string
  description = "Database name"
}
variable "rds_db_port" {
  type = number
  description = "Database port"
}
variable "rds_multi_az" {
  type = bool
  description = "(TRUE/FALSE)"
}
variable "rds_storage" {
  type = number
  description = "Allocated storage"
}
variable "rds_instance_class" {
  type = string
  description = "AWS Instance Class"
}
variable "rds_parameters" {
  type = list(object({
    name = string,
    value = string,
    apply = string
  }))
  description = "Parameter for RDS"
}
variable "is_prod" {
  type = bool
}
variable "vpc_id" {
  description = ""
}
variable "rds_subnet_white_list" {
  type = list(string)
}
variable "rds_custom_security_groups_list" {
  type = list(string)
}
variable "project_name" {
  type        = string
  description = "Application Name"
}
variable "tags" {
  type = map(string)
  description = "The tags"
}
variable "performance_insights_enabled" {
  type = bool
  description = "RDS Performance Insights Enabled"
  default = false
}
variable "performance_insights_retention_period" {
  type = number
  description = "RDS Performance Insights Retention Period"
  default = 0
}
variable "engine_version" {
  type = string
  description = "The engine version to use. If not specified, the latest engine version is used."
}
variable "engine_family" {
  type = string
  description = "The family of the database engine."
  default = "postgres15"
}
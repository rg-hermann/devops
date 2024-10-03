variable "cluster_id" {
  type        = string
  description = "ECS Cluster ID"
}
variable "cluster_name" {
  type        = string
  description = "ECS Cluster Name"
}
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

# === AWS ===
variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}
variable "aws_cloudwatch_retention_in_days" {
  type        = number
  description = "AWS CloudWatch Logs Retention in Days"
  default     = 1
}
variable "ecr_tag" {
  type        = string
  description = "ecr tag"
  default     = "latest"
}
# === Application ===
variable "container_port" {
  type        = number
  description = "Application Port"
}
variable "container_cpu" {
  type        = number
  description = "Application CPU"
}
variable "container_mem" {
  type        = number
  description = "Application Memory"
}
variable "container_health" {
  type        = string
  description = "Application Health Check"
  default     = ""
}
variable "autoscaling_min" {
  type        = number
  description = "Autoscalling Min"
  default     = 1
}
variable "autoscaling_max" {
  type        = number
  description = "Autoscalling Max"
  default     = 1
}
variable "autoscaling_desired" {
  type        = number
  description = "Autoscalling Desired"
  default     = 1
}
variable "environments" {
  type        = list(map(string))
  description = "The list of environment variables to create"
  default     = []
}
variable "secrets" {
  type        = list(map(string))
  description = "The list of ARNs secrets to allow access."
  default     = []
}

variable "bucket" {
  type        = list(map(string))
  description = "The list of ARNs buckets to allow access."
  default     = []
}
# === application loadbalancer ===
variable "alb_listener_ports" {
  type        = list(string)
  description = "Loadbalancer Listener Ports"
}
variable "alb_wafacl_name" {
  type        = string
  description = "Loadbalancer WAF name"
  default     = ""
}
variable "internal_alb" {
  type        = bool
  description = "Loadbalancer Internal"
  default     = true
}
variable "activate_waf" {
  type        = bool
  description = "Activate WAF"
  default     = false
}
variable "additional_ssl_ports" {
  type        = list(string)
  description = "Additional SSL Ports"
  default     = []
}
variable "target_groups" {
  type        = list(any)
  description = "The list of target groups and listeners"
}
variable "certificate_arn" {
  type        = string
  description = "Certificate ARN"
}
# === networking ===
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "List of private subnets"
}

variable "availability_zones" {
  description = "List of availability zones"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnets Ids"
  default     = []
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of public subnets Ids"
}

variable "vpn_subnet_white_list" {
  type        = list(string)
  description = "The CIDR blocks to allow access."
  default     = []
}
# === COMMON ===
variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to apply to all resources"
}
variable "project_name" {
  type        = string
  description = "Project name"
}
variable "visibility_timeout_seconds" {
  type        = number
  description = "Visibility timeout seconds"
  default     = 300
}

variable "message_retention_seconds" {
  type        = number
  description = "Message retention seconds"
  default     = 345600 # 4 days (minimum for SQS)
}

variable "delay_seconds" {
  type        = number
  description = "Delay seconds"
  default     = 0
}

variable "receive_wait_time_seconds" {
  type        = number
  description = "Receive wait time seconds"
  default     = 0
}

variable "sqs_managed_sse_enabled" {
  type        = bool
  description = "SSE enabled"
  default     = false
}

variable "dead_letter" {
  type        = any
  description = "Dead letter"
  default     = null
}

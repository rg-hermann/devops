variable "project_name" {
  description = "The base name for all resources in this module"
  type        = string
}

variable "kms_key_arn" {
  description = "The ARN of the KMS key for the backup vault"
  type        = string
  default     = null
}

variable "backup_vault_name" {
  type        = string
  description = "The name of the backup vault"
}

variable "backup_schedule" {
  description = "The CRON expression defining when the monthly backup should be run"
  type        = string
}

variable "cold_storage_after" {
  description = "The number of days after creation that the monthly recovery point should be moved to cold storage"
  type        = number
  default     = null
}

variable "lifecycle_delete_after" {
  description = "The number of days after creation that the monthly recovery point should be deleted"
  type        = number
  default     = 730
}
variable "enable_continuous_backup" {
  type        = bool
  description = "Enable continuous backup for the backup vault"
  default     = false
}

# Common Variables
variable "backup_resources" {
  description = "The list of ARNs of the resources to be backed up"
  type        = list(string)
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

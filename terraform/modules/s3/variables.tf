variable "bucket_name" {
  description = "The name of the bucket"
  type        = string
}

variable "enable_versioning" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = false
}

variable "transition_days" {
  description = "Number of days after which to transition objects to STANDARD_IA storage class"
  type        = number
  default     = 30
}

variable "expiration_days" {
  description = "Number of days after which to expire objects"
  type        = number
  default     = 365
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to assign to the bucket"
  type        = map(string)
  default     = {}
}

variable "env_name" {
  type        = string
  description = "The name of the environment to create"
  default     = "dev"
}
variable "app_environment" {
  type        = string
  description = "The name of the application to create"
}
variable "app_name" {
  type        = string
  description = "The name of the application to create"
}
variable "code_object" {
  type = object({
    key        = string
    version_id = string
  })
  description = "The S3 object that contains the Lambda code"
}
variable "layers_arn" {
  type        = list(string)
  description = "The list of layer ARNs"
  default     = []
}
variable "lambda_path_handler" {
  type        = string
  description = "The path to the lambda handler"
}
variable "bucket_id" {
  type        = string
  description = "The ID of the S3 bucket"
}
variable "bucket_arns" {
  type        = list(string)
  description = "The list of bucket ARNs"
  default     = []
}
variable "bucket_actions" {
  type        = list(string)
  description = "The list of bucket actions"
  default     = ["s3:GetObject"]
}
variable "cloudfront_arns" {
  type        = list(string)
  description = "The list of cloudfronts ARNs"
  default     = []
}
variable "cloudfront_actions" {
  type        = list(string)
  description = "The list of cloudfront actions"
  default     = ["cloudfront:CreateInvalidation"]
}
variable "principals_arns" {
  type        = list(string)
  description = "The list of principals ARNs"
  default     = []
}
variable "env_list" {
  type        = map(string)
  description = "The list of environments to create"
}
variable "secret_manager_arns" {
  type        = list(string)
  description = "The list of Secret Manager ARNs"
  default     = []
}
variable "kinesis_streams" {
  type        = list(string)
  description = "The kinesis stream names"
  default     = []
}
variable "on_failure_sns_arns" {
  type        = list(string)
  description = "The sns topic arns"
  default     = []
}
variable "batch_size" {
  type        = number
  description = "The number of records to send to Kinesis"
  default     = 100
}
variable "tags" {
  type        = map(string)
  description = "The tags to apply to the resources"
  default     = {}
}
variable "retry_attempts" {
  type        = number
  description = "Number of times to retry when the function returns an error."
  default     = 1
}
variable "schedule" {
  type        = list(string)
  default     = [] # "cron(0/30 * * * ? *)"
  description = "Schedule for the cron job"
}
variable "triggers" {
  type        = list(object({ rate = string, payload = string }))
  default     = [] # [{ rate = "rate(1 minute)", payload = "{}" }]
  description = "The list of triggers"
}
variable "subnet_ids" {
  type        = list(string)
  description = "The list of subnet ids"
  default     = []
}
variable "vpc_id" {
  type        = string
  description = "The security group identifier"
  default     = ""
}
variable "lambda_timeout" {
  type        = number
  description = "The lambda timeout"
  default     = 60
}
variable "port" {
  type        = number
  description = "The port to use for the lambda"
  default     = 443
}
variable "cidr_blocks" {
  type        = list(string)
  description = "The list of cidr blocks"
  default     = []
}
variable "runtime" {
  type        = string
  description = "The runtime to use for the lambda"
  default     = "nodejs20.x"
}
variable "lambda_memory_size" {
  type        = number
  description = "The lambda memory size"
  default     = 512
}
variable "trigger_sqs_arn" {
  type = list(string)
  description = "The trigger sqs lambda"
  default = []
}
variable "sqs_arns" {
  type = list(string)
  description = "The sqs arns to allow iam access"
  default = []
}
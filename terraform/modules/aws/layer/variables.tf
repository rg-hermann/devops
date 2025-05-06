variable "lambda_path_layer" {
  type        = string
  description = "The source directory for the lambda function"
}
variable "project_name" {
  type        = string
  description = "The name of the project"
}
variable "runtimes" {
  type        = list(string)
  description = "The runtimes for the lambda function"
}
variable "bucket_id" {
  type        = string
  description = "The ID of the S3 bucket"
}

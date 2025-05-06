output "arn" {
  description = "The ARN of the SQS queue"
  value       = local.queue.arn
}
output "id" {
  value = local.queue.id
  description = "The URL for the created Amazon SQS queue"
}

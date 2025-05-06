output "alb" {
  description = "Load Balancer URL"
  value       = module.alb_internal.alb_dns_name
  sensitive   = false
}
output "ecr" {
  description = "ECR URL"
  value       = aws_ecr_repository.aws-ecr.repository_url
  sensitive   = false
}
output "alb_dns_name" {
  value = module.alb_internal.alb_dns_name
}
output "alb_arn" {
  value = module.alb_internal.alb_arn
}
output "cloudfront_distribution_id" {
  description = "CF Id."
  value       = aws_cloudfront_distribution.distribution.id
}
output "cloudfront_distribution_domain_name" {
  description = "The domain name corresponding to the distribution."
  value       = aws_cloudfront_distribution.distribution.domain_name
}

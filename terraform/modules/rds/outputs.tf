output "rds_instance" {
  description = "RDS object"
  value       = aws_db_instance.db_instance
  sensitive   = false
}
output "rds_db_name" {
  description = "RDS object"
  value       = aws_db_instance.db_instance.db_name
  sensitive   = false
}
output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.db_instance.address
  sensitive   = false
}
output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.db_instance.port
  sensitive   = false
}
output "rds_username" {
  description = "RDS instance username"
  value       = var.rds_username
  sensitive   = false
}
output "password_version_arn" {
  value = aws_secretsmanager_secret_version.password.arn
}
output "password_name" {
  value = aws_secretsmanager_secret.rds_password_secret.name
}

output "instance_arn" {
  description = "instance arn"
  value       = aws_db_instance.db_instance.arn
}
output "password_version_arn" {
  value = aws_secretsmanager_secret_version.redis_admin.arn
}
output "password_name" {
  value = aws_secretsmanager_secret.redis_admin.name
}
output "db_host" {
  value = aws_elasticache_cluster.backend.cache_nodes[0].address
}
output "db_port" {
  value = aws_elasticache_cluster.backend.cache_nodes[0].port
}
output "db_user" {
  value = aws_elasticache_user.admin.user_name
}
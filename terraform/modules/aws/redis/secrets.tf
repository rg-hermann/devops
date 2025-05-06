resource "random_password" "redis_admin" {
  length           = 18
  special          = false
  override_special = ""
}

resource "aws_secretsmanager_secret" "redis_admin" {
  name = "${local.get_project}-redis-admin"
}

resource "aws_secretsmanager_secret_version" "redis_admin" {
  secret_id     = aws_secretsmanager_secret.redis_admin.id
  secret_string = random_password.redis_admin.result
}
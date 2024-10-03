resource "random_password" "password" {
  length           = 22
  special          = false
  override_special = ""
}
resource "aws_secretsmanager_secret" "rds_password_secret" {
  name = "${var.project_name}-secret-rds-password"
}
resource "aws_secretsmanager_secret_version" "password" {
  secret_id     = aws_secretsmanager_secret.rds_password_secret.id
  secret_string = random_password.password.result
}
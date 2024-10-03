resource "aws_cloudwatch_log_group" "log-group" {
  name              = "${var.project_name}-logs"
  retention_in_days = 7

  tags = merge({
    Name        = "${var.project_name}-logs"
    Application = var.project_name
    Environment = local.app_environment
  }, var.tags)
}
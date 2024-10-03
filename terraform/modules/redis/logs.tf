resource "aws_cloudwatch_log_group" "redis" {
  name = "${local.get_project}-redis-logs"
  retention_in_days = 7

  tags = merge({
    name = "${local.get_project}-redis-logs"
  },var.tags)
}
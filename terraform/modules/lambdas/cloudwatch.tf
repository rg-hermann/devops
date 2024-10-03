resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/aws/lambda/${local.get_name}"
  retention_in_days = 7
  tags = merge({
    Name = "/aws/lambda/${local.get_name}"
  },var.tags)
}
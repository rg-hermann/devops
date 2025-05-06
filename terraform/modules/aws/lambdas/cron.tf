resource "aws_cloudwatch_event_rule" "schedule" {
  count               = length(var.schedule)
  name                = "${local.get_name}-cron-${count.index}"
  description         = "Schedule for Lambda Function"
  schedule_expression = var.schedule[count.index]

  tags = merge({
    name = "${local.get_name}-cron-${count.index}"
  }, var.tags)
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_cloudwatch_event_target" "schedule_lambda" {
  count = length(var.schedule)
  rule  = aws_cloudwatch_event_rule.schedule[count.index].name
  arn   = aws_lambda_function.lambda.arn
}

resource "aws_lambda_permission" "allow_events_bridge" {
  count         = length(var.schedule)
  statement_id  = "${local.get_name}-${count.index}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.schedule[count.index].arn
}

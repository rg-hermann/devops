resource "aws_cloudwatch_event_rule" "trigger" {
  count               = length(var.triggers)
  name                = "${local.get_name}-trigger-${count.index}"
  description         = "Trigger for ${local.get_name} ${count.index}"
  schedule_expression = var.triggers[count.index].rate

  tags = merge({
    Name = "${local.get_name}-cron-${count.index}"
  }, var.tags)
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_cloudwatch_event_target" "trigger" {
  count     = length(var.triggers)
  rule      = aws_cloudwatch_event_rule.trigger[count.index].name
  target_id = "${local.get_name}-trigger-${count.index}"
  arn       = aws_lambda_function.lambda.arn

  input = jsonencode({
    "script" : "${var.triggers[count.index].payload}"
  })
}

resource "aws_lambda_permission" "allow_triggers" {
  count         = length(var.triggers)
  statement_id  = "${local.get_name}-bridge-${count.index}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.trigger[count.index].arn
}

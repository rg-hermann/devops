resource "aws_lambda_function" "lambda" {
  function_name     = local.get_name
  role              = aws_iam_role.role_for_lambda.arn
  runtime           = var.runtime
  s3_bucket         = var.bucket_id
  s3_key            = var.code_object.key
  s3_object_version = var.code_object.version_id
  handler           = var.lambda_path_handler
  timeout           = var.lambda_timeout
  memory_size       = var.lambda_memory_size
  publish           = true
  tracing_config {
    mode = "Active"
  }

  layers = var.layers_arn

  environment {
    variables = var.env_list
  }
  dynamic "vpc_config" {
    for_each = length(var.subnet_ids) > 0 ? [1] : []
    content {
      subnet_ids         = var.subnet_ids
      security_group_ids = [aws_security_group.lambda_security_group.id]
    }
  }

  tags = merge({
    Name = local.get_name
  }, var.tags)

  depends_on = [
    aws_iam_role.role_for_lambda, aws_cloudwatch_log_group.log_group
  ]

  lifecycle {
    ignore_changes = [
      source_code_hash,
      layers
    ]
  }
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  count            = length(var.trigger_sqs_arn) > 0 ? length(var.trigger_sqs_arn) : 0
  event_source_arn = var.trigger_sqs_arn[count.index]
  enabled          = true
  function_name    = aws_lambda_function.lambda.arn
  batch_size       = 1
}
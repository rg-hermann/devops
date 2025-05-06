data "aws_kinesis_stream" "stream" {
  count = length(var.kinesis_streams)
  name  = var.kinesis_streams[count.index]
}

resource "aws_lambda_event_source_mapping" "kinesis_triggers" {
  count                  = length(var.kinesis_streams)
  event_source_arn       = data.aws_kinesis_stream.stream[count.index].arn
  function_name          = aws_lambda_function.lambda.arn
  starting_position      = "LATEST"
  batch_size             = var.batch_size
  maximum_retry_attempts = 0
  dynamic "destination_config" {
    for_each = length(var.on_failure_sns_arns) > 0 ? [1] : []
    content {
      on_failure {
        destination_arn = var.on_failure_sns_arns[count.index]
      }
    }
  }
}

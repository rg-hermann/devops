resource "aws_sqs_queue" "queue" {
  count = local.is_dead_letter_active ? 0 : 1
  name                       = "${var.project_name}-sqs"
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds
  delay_seconds              = var.delay_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  sqs_managed_sse_enabled    = var.sqs_managed_sse_enabled

  tags = {
    Name        = "${var.project_name}-sqs"
  }
}

resource "aws_sqs_queue" "queue_with_dead_letter" {
  count = local.is_dead_letter_active ? 1 : 0
  name                       = "${var.project_name}-sqs-dlq"
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds
  delay_seconds              = var.delay_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  sqs_managed_sse_enabled    = var.sqs_managed_sse_enabled

  redrive_policy = jsonencode({
    deadLetterTargetArn = var.dead_letter.arn
    maxReceiveCount     = 4
  })

  tags = {
    Name        = "${var.project_name}-sqs-dlq"
  }

  depends_on = [var.dead_letter]
}

resource "aws_sqs_queue_redrive_allow_policy" "policy_dead_letter" {
  count = local.is_dead_letter_active ? 1 : 0
  queue_url = var.dead_letter.id

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.queue_with_dead_letter[0].arn]
  })

  depends_on = [var.dead_letter]
}

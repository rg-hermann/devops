locals {
  is_dead_letter_active = var.dead_letter == null ? false : true
  queue = local.is_dead_letter_active ? aws_sqs_queue.queue_with_dead_letter[0] : aws_sqs_queue.queue[0]
}

resource "aws_iam_role" "role_for_lambda" {
  name = "${local.get_name}-lambda"
  assume_role_policy = templatefile("${path.module}/policies/assume_role.json", {
    arns = var.principals_arns
  })
  tags = merge({
    Name = "${local.get_name}-lambda"
  }, var.tags)
}

resource "aws_iam_role_policy" "logging" {
  name = "${local.get_name}-cloudwatch"
  role = aws_iam_role.role_for_lambda.id
  policy = templatefile("${path.module}/policies/cloudwatch_policy.json", {
    log_group_arn = aws_cloudwatch_log_group.log_group.arn
  })
}

resource "aws_iam_role_policy" "kinesis_policy" {
  count = length(var.kinesis_streams)
  name  = "${local.get_name}-kinesis"
  role  = aws_iam_role.role_for_lambda.id
  policy = templatefile("${path.module}/policies/kinesis_policy.json", {
    kinesis_stream_arn = data.aws_kinesis_stream.stream.*.arn
  })
}

resource "aws_iam_role_policy" "secrets_manager_policy" {
  count = length(var.secret_manager_arns) > 0 ? 1 : 0
  name  = "${local.get_name}-secretsmanager"
  role  = aws_iam_role.role_for_lambda.id
  policy = templatefile("${path.module}/policies/secretmanager_policy.json", {
    secret_manager_arns = var.secret_manager_arns
  })
}

resource "aws_iam_role_policy" "networking_access" {
  count  = length(var.subnet_ids) > 0 ? 1 : 0
  name   = "${local.get_name}-networking-access"
  role   = aws_iam_role.role_for_lambda.id
  policy = file("${path.module}/policies/lambda_policies.json")
}

resource "aws_iam_role_policy" "sqs_policy" {
  count  = length(var.sqs_arns) > 0 ? 1 : 0
  name   = "${local.get_name}-sqs-access"
  role   = aws_iam_role.role_for_lambda.id
  policy = templatefile("${path.module}/policies/sqs_policy.json", {
    sqs_arns = var.sqs_arns
  })
}
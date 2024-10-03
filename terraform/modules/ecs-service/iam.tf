data "aws_iam_policy_document" "assume_by_ecs" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com",
        "lambda.amazonaws.com",
        "edgelambda.amazonaws.com"
      ]
    }
  }
}
# ----- TASK_EXECUTION_ROLE (ECS)-----
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.project_name}-execution-role"
  assume_role_policy = data.aws_iam_policy_document.assume_by_ecs.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]
  tags = {
    Name        = "${var.project_name}-execution-role"
    Environment = local.app_environment
    Application = var.project_name
  }
}


# ----- secrets -----
resource "aws_iam_role_policy" "secrets" {
  count = length(var.secrets) > 0 ? 1 : 0
  name  = "${var.project_name}-secret"
  role  = aws_iam_role.ecs_task_execution_role.id
  policy = templatefile("${path.module}/policies/secretmanager_policy.json", {
    arns = local.get_secret_arns
  })
}


# ----- TASK_ROLE (APP)-----
resource "aws_iam_role" "ecs_task_role" {
  name               = "${var.project_name}-execution-task-role"
  assume_role_policy = data.aws_iam_policy_document.assume_by_ecs.json
}

# ----- S3 -----
resource "aws_iam_role_policy" "s3" {
  count = length(var.bucket) > 0 ? 1 : 0
  name  = "${var.project_name}-s3"
  role  = aws_iam_role.ecs_task_role.id
  policy = templatefile("${path.module}/policies/s3_policy.json", {
    arns = local.get_s3_arns
  })
}

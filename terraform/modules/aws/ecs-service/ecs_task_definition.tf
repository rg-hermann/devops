data "template_file" "task_definition" {
  template = file("${path.module}/templates/task_definition.json")
  vars     = merge(local.container_list, local.env_list)
}

resource "aws_ecs_task_definition" "aws-ecs-task" {
  family = "${var.project_name}-task"

  container_definitions = data.template_file.task_definition.rendered

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  memory                   = var.container_mem
  cpu                      = var.container_cpu
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  tags = merge({
    Name        = "${var.project_name}-ecs"
    Environment = local.app_environment
    Application = var.project_name
  }, var.tags)
}

data "aws_ecs_task_definition" "main" {
  task_definition = aws_ecs_task_definition.aws-ecs-task.family
}
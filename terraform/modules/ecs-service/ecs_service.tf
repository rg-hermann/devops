resource "aws_ecs_service" "aws-ecs-service" {
  name                 = var.project_name
  cluster              = var.cluster_id
  task_definition      = "${aws_ecs_task_definition.aws-ecs-task.family}:${max(aws_ecs_task_definition.aws-ecs-task.revision, data.aws_ecs_task_definition.main.revision)}"
  # launch_type          = "FARGATE"
  scheduling_strategy  = "REPLICA"
  desired_count        = var.autoscaling_desired
  force_new_deployment = false
  propagate_tags       = "SERVICE"

  network_configuration {
    subnets          = var.private_subnet_ids
    assign_public_ip = false
    security_groups = [
      aws_security_group.service_security_group.id
    ]
  }
  load_balancer {
    target_group_arn = module.alb_internal.target_groups[0].arn
    container_name   = "${var.project_name}-container"
    container_port   = var.container_port
  }

  dynamic "capacity_provider_strategy" {
    for_each = local.is_prod ? [] : [1]
    content {
      capacity_provider = "FARGATE_SPOT"
      weight = 2
      base = 0
    }
  }

  deployment_controller {
    type = "ECS" #"CODE_DEPLOY" # ECS
  }
  lifecycle {
    ignore_changes = [desired_count, force_new_deployment, task_definition]
  }
  tags = merge({
    Name        = var.project_name
    Environment = local.app_environment
    Application = var.project_name
  }, var.tags)
}

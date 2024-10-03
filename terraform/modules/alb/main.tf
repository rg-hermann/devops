resource "aws_alb" "application_load_balancer" {
  name               = "${var.project_name}${var.alb_name}alb"
  internal           = var.internal
  enable_deletion_protection = var.enable_deletion_protection
  load_balancer_type = var.balancer_type
  subnets            = var.internal ? var.private_subnet_ids : var.public_subnet_ids
  security_groups    = var.balancer_type == "network" ? [] : [aws_security_group.load_balancer_security_group[0].id]
  drop_invalid_header_fields = true

  tags = merge({
    Name        = "${var.project_name}-alb"
  },var.tags)
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_lb_target_group" "target_group" {
  count       = length(var.target_groups)
  name        = "${var.project_name}${var.alb_name}${var.target_groups[count.index].name}"
  port        = var.application_port
  protocol    = local.is_tcp ? "TCP" : "HTTP"
  target_type = lookup(var.target_groups[count.index], "target_type", "alb")
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = "3"
    interval            = "10"
    protocol            = "HTTP"
    matcher             = "200-399"
    timeout             = "3"
    path                = var.target_groups[count.index].health_check_path
    unhealthy_threshold = "2"
  }
  tags = merge({
    name        = "${var.project_name}-${var.target_groups[count.index].name}"
  },var.tags)
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_alb_listener" "listener" {
  count             = length(var.target_groups)
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = var.target_groups[count.index].listener_port
  protocol          = var.target_groups[count.index].protocol
  certificate_arn   = var.internal ? "" : var.certificate_arn
  default_action {
    target_group_arn = aws_lb_target_group.target_group[count.index].arn
    type             = "forward"
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_alb_listener" "additional_ssl_listener" {
  count             = length(var.additional_ssl_ports)
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = var.additional_ssl_ports[count.index]
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn
  default_action {
    target_group_arn = aws_lb_target_group.target_group[0].arn
    type             = "forward"
  }
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_lb_listener_rule" "rule_block" {
  count        = length(local.get_listener_rules)
  listener_arn = aws_alb_listener.listener[count.index].arn
  priority     = sum([100,count.index])
  action {
    type              = "redirect"
    target_group_arn  = aws_alb.application_load_balancer.arn
    redirect {
      path        = "/"
      port        = local.listener_rules[count.index].listener_port
      protocol    = local.listener_rules[count.index].protocol
      status_code = "HTTP_301"
    }
  }
  condition {
    path_pattern {
      values = local.listener_rules[count.index].block_paths
    }
  }
  lifecycle {
    ignore_changes = [tags, priority]
  }
}
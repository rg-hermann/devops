resource "aws_security_group" "service_security_group" {
  vpc_id = var.vpc_id
  name   = "${var.project_name}-service-sg"
  description = "Security group for ECS service"

  ingress {
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    cidr_blocks     = local.subnet_white_list
    security_groups = [aws_security_group.load_balancer_security_group.id]
    description     = "Allow all outbound traffic from the load balancer"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic to the load balancer"
  }
  lifecycle {
    ignore_changes = [description]
  }
  tags = merge({
    Name        = "${var.project_name}-ecs-ervice-sg"
    Environment = local.app_environment
    Application = var.project_name
  }, var.tags)
}

resource "aws_security_group" "load_balancer_security_group" {
  vpc_id = var.vpc_id
  name   = "${var.project_name}-alb-sg"
  description = "Security group for ECS load balancer"

  dynamic "ingress" {
    for_each        = var.alb_listener_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol      = "tcp"
      cidr_blocks   = ["0.0.0.0/0"]
      description = "Allow all inbound traffic from the load balancer"
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic to the load balancer"
  }
  lifecycle {
    ignore_changes = [description]
  }
  tags = merge({
    Name        = "${var.project_name}-alb-sg"
    Environment = local.app_environment
    Application = var.project_name
  }, var.tags)
}
resource "aws_security_group" "load_balancer_security_group" {
  count = var.balancer_type == "network" ? 0 : 1
  vpc_id = var.vpc_id
  name   = "${var.project_name}${var.alb_name}load-balancer-security-group"
  description     = "Load Balancer Security Group"

  dynamic "ingress" {
    for_each      = local.get_listener_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic from the internet"
    }
  }
  egress {
    description      = "Allow all outbound traffic to the internet"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = merge({
    name        = "${var.project_name}${var.alb_name}alb-sg"
  },var.tags)
  lifecycle {
    ignore_changes = [tags, description]
  }
}
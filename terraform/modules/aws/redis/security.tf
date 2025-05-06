
resource "aws_security_group" "redis" {
  vpc_id = var.vpc_id
  name   = "${local.get_project}-redis-sg"
  description = "${local.get_project}-redis-sg"

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow all outbound traffic"
  }
  tags = merge({
    name        = "${local.get_project}-redis-sg"
  },var.tags)
  lifecycle {
    ignore_changes = [tags,description]
  }
}

resource "aws_security_group_rule" "this" {
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  cidr_blocks       = concat(var.private_subnets,var.subnet_white_list)
  description       = "Allow access Redis"
  security_group_id = aws_security_group.redis.id
}
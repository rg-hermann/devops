resource "aws_security_group" "lambda_security_group" {
  vpc_id      = var.vpc_id
  name        = "${local.get_name}-lambda-sg"
  description = "Security group for Lambda xxxxx"

  ingress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
    description = "Allow access https"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = merge({
    Name = "${local.get_name}-lambda-sg"
  }, var.tags)

  lifecycle {
    ignore_changes = [tags, description]
  }
}

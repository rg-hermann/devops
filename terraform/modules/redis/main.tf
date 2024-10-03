resource "aws_elasticache_cluster" "backend" {
  cluster_id           = "${local.get_project}-cluster"
  engine               = var.engine
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = "default.redis6.x"
  engine_version       = var.engine_version
  port                 = var.port
  apply_immediately    = true
  subnet_group_name    = aws_elasticache_subnet_group.this.name
  security_group_ids   = [aws_security_group.redis.id]

  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.redis.name
    destination_type = "cloudwatch-logs"
    log_format       = "text"
    log_type         = "slow-log"
  }

  tags = merge({ name = "${local.get_project}-cluster" },
    var.tags
  )
  lifecycle {
    ignore_changes = [tags]
  }
}

resource "aws_elasticache_subnet_group" "this" {
  name       = "${local.get_project}-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = merge({ name = "${local.get_project}-subnet-group" },
    var.tags
  )
}

resource "aws_elasticache_user" "admin" {
  user_id       = var.admin_user_id
  user_name     = "${local.get_project}-admin"
  access_string = var.admin_access_string
  engine        = upper(var.engine)
  passwords     = [random_password.redis_admin.result]

  tags = merge({ name = "${local.get_project}-admin-redis-user" },
    var.tags
  )
}

resource "aws_elasticache_user_group" "this" {
  engine        = upper(var.engine)
  user_group_id = var.user_group_id
  user_ids      = ["default", aws_elasticache_user.admin.user_id]

  lifecycle {
    ignore_changes = [user_ids]
  }
}
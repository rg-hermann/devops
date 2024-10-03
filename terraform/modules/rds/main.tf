resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.project_name}-subnet-group-rds"
  subnet_ids = var.subnet_ids
  description = "DB Subnet Group for RDS"

  tags = merge({
    name        = "${var.project_name}-subnet-group-rds"
  },var.tags)
  lifecycle {
    ignore_changes = [description,tags]
  }
}

resource "aws_db_parameter_group" "db_parameter_group" {
  name        = "${var.project_name}-db-parameter-group-rds"
  family      = var.engine_family
  description = "DB Parameter Group for RDS"

  dynamic "parameter" {
    for_each = var.rds_parameters
    content {
        apply_method   = parameter.value.apply
        name           = parameter.value.name
        value          = parameter.value.value
    }
  }
  tags = merge({
    name        = "${var.project_name}-subnet-group-rds"
  },var.tags)
  lifecycle {
    ignore_changes = [description,tags]
  }
}

resource "aws_db_instance" "db_instance" {
  identifier                            = "${var.project_name}-db-instance"
  instance_class                        = var.rds_instance_class
  allocated_storage                     = var.rds_storage
  max_allocated_storage                 = 1000
  engine                                = "postgres"
  engine_version                        = var.engine_version
  username                              = "postgresql"
  password                              = aws_secretsmanager_secret_version.password.secret_string
  db_name                               = var.rds_db_name
  port                                  = var.rds_db_port
  allow_major_version_upgrade           = false
  auto_minor_version_upgrade            = false
  db_subnet_group_name                  = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids                = [aws_security_group.rds.id]
  parameter_group_name                  = aws_db_parameter_group.db_parameter_group.name
  publicly_accessible                   = false
  skip_final_snapshot                   = false
  multi_az                              = var.rds_multi_az
  deletion_protection                   = true
  backup_window                         = "04:00-06:00"
  backup_retention_period               = 1
  final_snapshot_identifier             = "${var.project_name}-final-backup"
  storage_encrypted                     = var.is_prod ? true : false
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period
  apply_immediately                     = true
  tags = merge({
    name        = "${var.project_name}-db-instance"
  },var.tags)
  lifecycle {
    ignore_changes        = [tags,backup_retention_period]
  }
}

resource "aws_security_group" "rds" {
  name          = "${var.project_name}-security_group-rds"
  description   = "Security Group for RDS"
  vpc_id        = var.vpc_id

  ingress {
    from_port   = var.rds_db_port
    to_port     = var.rds_db_port
    protocol    = "tcp"
    cidr_blocks = var.rds_subnet_white_list
    description = "Allow RDS Postgres access"
    security_groups = var.rds_custom_security_groups_list
  }

  egress {
    from_port   = var.rds_db_port
    to_port     = var.rds_db_port
    protocol    = "tcp"
    cidr_blocks = var.rds_subnet_white_list
    description = "Allow RDS Postgres access"
  }
  tags = merge({
    name        = "${var.project_name}-security_group-rds"
  },var.tags)
  lifecycle {
    ignore_changes = [description, tags]
  }
}
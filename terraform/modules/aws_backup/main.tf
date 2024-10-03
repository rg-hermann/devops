resource "aws_backup_plan" "backup_plan" {
  name = "${var.project_name}-plan"

  rule {
    rule_name                = "${var.project_name}-rule"
    target_vault_name        = var.backup_vault_name
    schedule                 = var.backup_schedule
    enable_continuous_backup = var.enable_continuous_backup
    lifecycle {
      cold_storage_after = var.cold_storage_after != null ? var.cold_storage_after : null
      delete_after       = var.lifecycle_delete_after
    }

    recovery_point_tags = {
      Name = "${var.project_name}-plan"
    }
  }
}
resource "aws_backup_selection" "backup_selection" {
  iam_role_arn = aws_iam_role.backup_role.arn
  name         = "${var.project_name}-selection"
  plan_id      = aws_backup_plan.backup_plan.id
  resources    = var.backup_resources
}

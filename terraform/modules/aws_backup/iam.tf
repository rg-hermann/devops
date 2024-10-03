resource "aws_iam_role" "backup_role" {
  name = "${var.project_name}-backup-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "backup.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
data "aws_iam_policy" "backup_iam_policy" {
  name = "AWSBackupServiceRolePolicyForBackup"
}

data "aws_iam_policy" "restore_iam_policy" {
  name = "AWSBackupServiceRolePolicyForRestores"
}

resource "aws_iam_role_policy_attachment" "backup_policy_attach" {
  policy_arn = data.aws_iam_policy.backup_iam_policy.arn
  role       = aws_iam_role.backup_role.name
}

resource "aws_iam_role_policy_attachment" "restore_policy_attach" {
  policy_arn = data.aws_iam_policy.restore_iam_policy.arn
  role       = aws_iam_role.backup_role.name
}
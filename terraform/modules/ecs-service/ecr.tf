resource "aws_ecr_repository" "aws-ecr" {
  name = "${var.project_name}-repo"
  image_scanning_configuration {
    scan_on_push = true
  }
  image_tag_mutability = "MUTABLE"
  tags = merge({
    Name        = "${var.project_name}-repo"
    Environment = local.app_environment
    Application = var.project_name
  }, var.tags)
}

resource "aws_ecr_lifecycle_policy" "ecr_policy" {
  repository = aws_ecr_repository.aws-ecr.name

  policy = templatefile("${path.module}/policies/ecr_policy.json", {
    untagged_retention = 7, tagged_retention = 30
  })
}
data "archive_file" "code" {
  type        = "zip"
  source_dir  = var.lambda_path_code
  output_path = "${path.module}/outputs/${var.project_name}-code.zip"
}

resource "aws_s3_object" "lambda_code_zip" {
  bucket = var.bucket_id
  key    = "code/${var.project_name}-code.zip"
  source = data.archive_file.code.output_path

  depends_on = [data.archive_file.code]

  lifecycle {
    ignore_changes = [tags_all]
  }
}
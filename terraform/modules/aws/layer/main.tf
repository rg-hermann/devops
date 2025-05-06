data "archive_file" "layer" {
  type        = "zip"
  source_dir  = var.lambda_path_layer
  output_path = "${path.module}/outputs/${var.project_name}-layer.zip"
}

resource "aws_s3_object" "lambda_layer_zip" {
  bucket = var.bucket_id
  key    = "layer/${var.project_name}-layer.zip"
  source = data.archive_file.layer.output_path

  depends_on = [data.archive_file.layer]

  lifecycle {
    ignore_changes = [tags_all]
  }
}

resource "aws_lambda_layer_version" "layer" {
  layer_name               = "${var.project_name}-layer"
  s3_bucket                = var.bucket_id
  s3_key                   = aws_s3_object.lambda_layer_zip.key
  description              = "${var.project_name}-layer"
  source_code_hash         = data.archive_file.layer.output_base64sha256
  compatible_runtimes      = var.runtimes
  compatible_architectures = ["x86_64"]

  lifecycle {
    ignore_changes = [
      source_code_hash
    ]
  }
}


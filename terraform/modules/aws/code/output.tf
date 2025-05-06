output "code_object" {
  value = {
    key        = aws_s3_object.lambda_code_zip.key
    version_id = aws_s3_object.lambda_code_zip.version_id
  }
}

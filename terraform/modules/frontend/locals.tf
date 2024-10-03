locals {
  get_project = "${var.app_name}-${var.env_name}"
  s3_origin_id = "origin-${aws_s3_bucket.build.bucket_domain_name}"
}
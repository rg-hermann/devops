resource "aws_s3_bucket" "build" {
  bucket = "${local.get_project}-build"

  tags = merge({ Name = "${local.get_project}-build" }, var.tags)
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.build.id
  acl    = "private"
}

resource "aws_s3_bucket_cors_configuration" "cors" {
  bucket = aws_s3_bucket.build.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_object" "current" {
  bucket       = aws_s3_bucket.build.id
  content_type = "application/x-directory"
  key          = var.origin_path
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.build.id

  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

data "aws_iam_policy_document" "policy_document" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.build.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.access_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "devops_app_bucket_policy" {
  bucket = aws_s3_bucket.build.id
  policy = data.aws_iam_policy_document.policy_document.json
}

resource "aws_s3_bucket_website_configuration" "bucket_website" {
  bucket = aws_s3_bucket.build.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_ownership_controls" "website_controls" {
  bucket = aws_s3_bucket.build.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  force_destroy = true
  tags = merge({
    Name = var.bucket_name
  }, var.tags)
}
resource "aws_s3_bucket_ownership_controls" "controls" {
  bucket = aws_s3_bucket.this.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_acl" "bucket_acl" {
  bucket     = aws_s3_bucket.this.id
  acl        = "private"
  depends_on = [aws_s3_bucket_ownership_controls.controls]
}

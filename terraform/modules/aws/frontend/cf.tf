resource "aws_cloudfront_response_headers_policy" "response_headers_cors" {
  name  = "${local.get_project}-cors"
  cors_config {
    access_control_allow_credentials = false
    access_control_allow_headers {
      items = ["*"]
    }
    access_control_allow_methods {
      items = ["GET", "HEAD", "OPTIONS"]
    }
    access_control_allow_origins {
      items = [for item in concat(var.allowed_cors_domains,var.aliases) : item]
    }
    origin_override = true
  }
}

resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name = aws_s3_bucket.build.bucket_regional_domain_name
    origin_id   = local.s3_origin_id
    origin_path = var.origin_path

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.access_identity.cloudfront_access_identity_path
    }
  }

  retain_on_delete    = true
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = var.aliases

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = local.s3_origin_id
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 3600
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true

    response_headers_policy_id = aws_cloudfront_response_headers_policy.response_headers_cors.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    lambda_function_association {
      event_type = "origin-response"
      lambda_arn = aws_lambda_function.lambda_edge_origin_response.qualified_arn
    }
    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.url_rewriter.arn
    }
  }



  price_class = "PriceClass_All"

  tags = merge({ Name = "${local.get_project}-app" }, var.tags)

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.certificate_arn
    minimum_protocol_version = "TLSv1.2_2018"
    ssl_support_method       = "sni-only"
  }
}

resource "aws_cloudfront_origin_access_identity" "access_identity" {
  comment = "Cloud front identity for ${local.get_project}"
}

resource "aws_cloudfront_function" "url_rewriter" {
  name    = "${local.get_project}-url-rewriter"
  runtime = "cloudfront-js-1.0"
  publish = true
  code    = file("${path.module}/src/url_rewrite/index.js")
}
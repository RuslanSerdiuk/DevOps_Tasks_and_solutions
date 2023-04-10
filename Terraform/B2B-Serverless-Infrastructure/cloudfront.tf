locals {
  s3_origin_id = "S3Origin"
}

resource "aws_cloudfront_origin_access_identity" "my_origin_access_identity" {
  comment = "Some comment"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.B2B_Project_bucket.bucket_regional_domain_name
#    origin_access_control_id = aws_cloudfront_origin_access_control.p2p_project_access_policy.id
    origin_id                = local.s3_origin_id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.my_origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "B2B project CloudFront distribution"
  default_root_object = "index.html"

  custom_error_response{
    error_code         = "403"
    response_code      = "200"
    response_page_path = "/index.html"
  }

  logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.B2B_Project_bucket.bucket_regional_domain_name
    prefix          = "logs/cloudfront-logs/"
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }
  
  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  tags = {
    "Name"                    = var.finance_product
    "Role"                    = "${var.backend_role}-${var.finance_env}"
    "Environment"             = var.name_env
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

/*
resource "aws_cloudfront_origin_access_control" "p2p_project_access_policy" {
  name                              = "p2p_project_access_policy"
  description                       = "p2p_project_access_policy Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
*/
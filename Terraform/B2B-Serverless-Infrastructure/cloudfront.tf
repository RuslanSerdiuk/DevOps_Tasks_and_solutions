locals {
  s3_origin_id = "S3Origin"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.B2B_Project_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.p2p_project_access_policy.id
    origin_id                = local.s3_origin_id
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "index.html"

  custom_error_response{
    error_code         = "403"
    response_code      = "200"
    response_page_path = "/index.html"
  }

  logging_config {
    include_cookies = false
    bucket          = "mylogs.s3.amazonaws.com"
    prefix          = "myprefix"
  }

  aliases = ["mysite.p2p_project_access_policy.com", "yoursite.p2p_project_access_policy.com"]

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
  
  tags = {
    "Name"                    = "${var.role}-${var.finance_env}"
    "Role"                    = "${var.role}-${var.finance_env}"
    "EpicFinance:Environment" = var.finance_env
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}


resource "aws_cloudfront_origin_access_control" "p2p_project_access_policy" {
  name                              = "p2p_project_access_policy"
  description                       = "p2p_project_access_policy Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
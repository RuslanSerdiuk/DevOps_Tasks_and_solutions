########################### CloudFront Distribution [Frontend] ###################################
resource "aws_cloudfront_distribution" "s3_distribution_for_frontend" {
  origin {
    domain_name              = aws_s3_bucket.B2B_Project_bucket_for_frontend.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.access_policy_for_frontend_distribution.id
    origin_id                = var.frontend_name_bucket
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "B2B-project-${var.backend_role_frontend}-${var.name_env}"
  default_root_object = "index.html"

  custom_error_response{
    error_code            = "403"
    response_code         = "200"
    response_page_path    = "/index.html"
    error_caching_min_ttl = 10
  }

  logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.B2B_Project_bucket_for_frontend.bucket_regional_domain_name
    prefix          = "logs/cloudfront-logs/${var.backend_role_frontend}-${var.name_env}"
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.frontend_name_bucket

    cache_policy_id            = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    response_headers_policy_id = "5cc3b908-e619-4b99-88e5-2cf7f45965bd"


    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
  }
  
  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  tags = {
    "Name"                    = var.finance_product
    "Role"                    = "${var.backend_role_frontend}-${var.name_env}"
    "Environment"             = var.finance_env
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

resource "aws_cloudfront_origin_access_control" "access_policy_for_frontend_distribution" {
  name                              = "access_policy_for_frontend_distribution"
  description                       = "p2p project ${var.backend_role_frontend}-${var.name_env} access policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

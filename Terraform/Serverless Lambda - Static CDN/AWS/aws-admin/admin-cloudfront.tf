########################### CloudFront Distribution [Admin] ###################################
resource "aws_cloudfront_distribution" "s3_distribution_for_admin" {
  origin {
    domain_name              = aws_s3_bucket.B2B_Project_bucket_for_admin.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.access_policy_for_admin_distribution.id
    origin_id                = var.backend_role
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "${var.backend_role}-${var.name_env}"
  default_root_object = var.default_root_object

  custom_error_response{
    error_code            = var.error_code
    response_code         = var.response_code
    response_page_path    = var.response_page_path
    error_caching_min_ttl = var.error_caching_min_ttl
  }

  logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.B2B_Project_bucket_for_admin.bucket_regional_domain_name
    prefix          = "${var.prefix_logging_group}/${var.backend_role}-${var.name_env}"
  }

  default_cache_behavior {
    allowed_methods  = var.cache_allowed_methods
    cached_methods   = var.cached_methods
    target_origin_id = var.backend_role

    cache_policy_id            = var.cache_policy_id
    response_headers_policy_id = var.resp_head_policy_id


    viewer_protocol_policy = var.protocol_policy
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
    "Role"                    = "${var.backend_role}-${var.name_env}"
    "Environment"             = var.finance_env
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

resource "aws_cloudfront_origin_access_control" "access_policy_for_admin_distribution" {
  name                              = "access-policy-for-${var.backend_role}-${var.name_env}-distribution"
  description                       = "p2p project ${var.backend_role}-${var.name_env} access policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

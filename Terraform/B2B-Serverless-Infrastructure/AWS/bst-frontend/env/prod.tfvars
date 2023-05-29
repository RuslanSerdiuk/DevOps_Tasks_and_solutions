############################
# Tags                     #
############################
backend_role          = "mach-bst-frontend"
finance_product       = "b2b_project"
finance_env           = "prod"
name_env              = "pd"

############################
# S3                       #
############################
bucket_name           = "mach-bst-frontend"

############################
# CloudFront               #
############################
default_root_object   = "index.html"
prefix_logging_group  = "logs/cloudfront-logs"
protocol_policy       = "redirect-to-https"
cache_policy_id       = "658327ea-f89d-4fab-a63d-7e88639e58f6"
resp_head_policy_id   = "5cc3b908-e619-4b99-88e5-2cf7f45965bd"
cache_allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
cached_methods        = ["GET", "HEAD"]

### CustomErrorResponse ###
error_code            = "403"
response_code         = "200"
response_page_path    = "/index.html"
error_caching_min_ttl = 10
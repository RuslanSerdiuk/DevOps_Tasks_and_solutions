############################
# S3                       #
############################

output "S3Bucket_ID" {
  value = aws_s3_bucket.B2B_Project_bucket.id
}

############################
# Lambda                   #
############################

output "Lambda_ID" {
  value = aws_lambda_function.serverless_mach.id
}

############################
# CloudWatch               #
############################

output "Cloudwatch_Event_Trigger" {
  value = aws_cloudwatch_event_rule.b2b_project_fift_min_event.arn
}

############################
# CloudFront               #
############################

output "CloudFront_Distribution_ID" {
  value = aws_cloudfront_distribution.s3_distribution.arn
}

############################
# API Gateway              #
############################

output "API_Gateway" {
  value = aws_apigatewayv2_api.serverless_mach_api.arn
}

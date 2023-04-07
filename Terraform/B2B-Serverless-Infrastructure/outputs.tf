############################
# S3                       #
############################

output "S3Bucket_id" {
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

output "aws_cloudwatch_event_trigger" {
  value = aws_cloudwatch_event_rule.b2b_project_fift_min_event.arn
}

############################
# S3                       #
############################

output "S3Bucket_id" {
  value = aws_s3_bucket.Export_DynamoDB.id
}

############################
# Lambda                   #
############################

output "Lambda_ID" {
  value = aws_lambda_function.trigger_lambda_warming.id
}

############################
# CloudWatch               #
############################

output "aws_cloudwatch_event_trigger" {
  value = aws_cloudwatch_event_rule.b2b_project_fift_min_event.arn
}
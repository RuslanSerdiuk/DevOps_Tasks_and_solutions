############################
# S3                       #
############################

output "S3Bucket_ID" {
  value = aws_s3_bucket.B2B_Project_bucket_for_serverless_backend.id
}

############################
# Lambda                   #
############################

###### Backend Lambda ######
output "Backend_lambda_ID" {
  value = aws_lambda_function.lambda_for_serverless_backend.id
}

#### API Trigger Lambda ####
output "API_call_lambda_ID" {
  value = aws_lambda_function.lambda_for_api_call.id
}

############################
# CloudWatch               #
############################

output "Cloudwatch_Event_Trigger_For_Backend_Lambda" {
  value = aws_cloudwatch_event_rule.b2b_project_fift_min_event.arn
}

output "Cloudwatch_Event_Trigger_For_API_Call_Lambda" {
  value = aws_cloudwatch_event_rule.b2b_project_twelve_hours_event.arn
}

############################
# API Gateway              #
############################

output "API_Gateway" {
  value = aws_apigatewayv2_api.lambda_for_serverless_backend_api.arn
}

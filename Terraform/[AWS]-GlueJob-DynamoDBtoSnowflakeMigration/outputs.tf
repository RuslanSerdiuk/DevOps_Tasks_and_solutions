############################
# Glue                     #
############################

output "Glue_job_id" {
  value = aws_glue_job.export_DB.id
}

############################
# S3                       #
############################

output "S3Bucket_id" {
  value = aws_s3_bucket.Export_DynamoDB.id
}

############################
# Secret Manager           #
############################
/*
output "Snowflake_credentials_ID" {
  value = aws_secretsmanager_secret.Snowflake_credentials.id
}
*/
############################
# Lambda                   #
############################

output "Lambda_ID" {
  value = aws_lambda_function.export_from_s3_to_snowflake.id
}

############################
# CloudWatch               #
############################

output "aws_cloudwatch_event_rule" {
  value = aws_cloudwatch_event_rule.alarm.arn
}

############################
# SNS                      #
############################





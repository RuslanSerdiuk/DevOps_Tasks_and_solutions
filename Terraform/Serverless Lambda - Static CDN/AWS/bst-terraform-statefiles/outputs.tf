############################
# S3                       #
############################

output "S3Bucket_for_statefiles_ID" {
  value = aws_s3_bucket.terraform_state.id
}

############################
# DynamoDB Table           #
############################

output "DynamoDB_table_for_statelock_ID" {
  value = aws_dynamodb_table.terraform_state_locks.arn
}

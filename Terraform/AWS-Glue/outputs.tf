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
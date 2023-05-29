############################
# S3                       #
############################

output "S3Bucket__Admin_ID" {
  value = aws_s3_bucket.B2B_Project_bucket_for_admin.id
}

############################
# CloudFront               #
############################

output "CloudFront_Admin_Distribution_ID" {
  value = aws_cloudfront_distribution.s3_distribution_for_admin.arn
}

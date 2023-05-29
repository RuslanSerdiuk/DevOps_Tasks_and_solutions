############################
# S3                       #
############################

output "S3Bucket__Frontend_ID" {
  value = aws_s3_bucket.B2B_Project_bucket_for_frontend.id
}

############################
# CloudFront               #
############################

output "CloudFront_Frontend_Distribution_ID" {
  value = aws_cloudfront_distribution.s3_distribution_for_frontend.arn
}

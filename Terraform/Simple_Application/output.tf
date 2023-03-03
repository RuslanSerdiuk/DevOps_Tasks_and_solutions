output "RDS_endpoint" {
  value = module.database.RDS_Endpoint
}

output "Bastion_public_DNS" {
  description = "Bastion Host Public DNS"
  value = module.ec2.aws_instance_public_ip
}

output "s3_bucket_id" {
  value = module.s3.S3Bucket_id
}
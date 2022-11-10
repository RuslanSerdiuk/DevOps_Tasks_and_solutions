#======================================CREATE S3==========================================#
  resource "aws_s3_bucket" "TF_Bucket" {
    bucket = var.name_bucket

    tags = {
      Name = "${var.name}_TF_Bucket"
    }
  }

  resource "aws_s3_bucket_acl" "example" {
    bucket = aws_s3_bucket.TF_Bucket.id
    acl    = "private"
  }

  resource "aws_s3_bucket_public_access_block" "Public_access_block" {
    bucket = aws_s3_bucket.TF_Bucket.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }

#===================================Upload files to S3====================================#
resource "aws_s3_object" "python_script" {
  for_each      = fileset(var.upload_directory, "**/*.*")
  bucket        = aws_s3_bucket.TF_Bucket.bucket
  key           = replace(each.value, var.upload_directory, "")
  source        = "${var.upload_directory}${each.value}"
  etag          = filemd5("${var.upload_directory}${each.value}")
  content_type  = lookup(var.mime_types, split(".", each.value)[length(split(".", each.value)) - 1])
}
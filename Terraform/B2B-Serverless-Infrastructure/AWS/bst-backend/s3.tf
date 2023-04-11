#======================================CREATE S3==========================================#
  resource "aws_s3_bucket" "B2B_Project_bucket_for_serverless_backend" {
    bucket = "${var.name_bucket}-${var.name_env}"

      tags = {
        "Name"                    = var.finance_product
        "Role"                    = "${var.backend_role}-${var.name_env}"
        "Environment"             = var.finance_env
      }
  }

  resource "aws_s3_bucket_public_access_block" "access_block_for_serverless_bucket_backend" {
    bucket = aws_s3_bucket.B2B_Project_bucket_for_serverless_backend.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }


resource "aws_s3_bucket_acl" "Project_bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.ownership_control_for_b2b_project_bucket_for_serverless_backend]

  bucket = aws_s3_bucket.B2B_Project_bucket_for_serverless_backend.id
  acl    = "private"
}

resource "aws_s3_bucket_ownership_controls" "ownership_control_for_b2b_project_bucket_for_serverless_backend" {
  bucket = aws_s3_bucket.B2B_Project_bucket_for_serverless_backend.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


#===================================Upload files to S3====================================#
resource "aws_s3_object" "upload_objects" {
  for_each      = fileset(var.upload_directory, "**/*.*")
  bucket        = aws_s3_bucket.B2B_Project_bucket_for_serverless_backend.bucket
  key           = replace(each.value, var.upload_directory, "")
  source        = "${var.upload_directory}${each.value}"
  etag          = filemd5("${var.upload_directory}${each.value}")
  content_type  = lookup(var.mime_types, split(".", each.value)[length(split(".", each.value)) - 1])
}
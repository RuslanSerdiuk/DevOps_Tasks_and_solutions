#======================================CREATE S3==========================================#
  resource "aws_s3_bucket" "B2B_Project_bucket" {
    bucket = "${var.name_bucket}-${var.name_env}"

      tags = {
      Name                      = "${var.backend_role}-${var.finance_env}"
      Role                      = "${var.backend_role}-${var.finance_env}"
      "EpicFinance:Environment" = var.finance_env
   }
  }

  resource "aws_s3_bucket_public_access_block" "export" {
    bucket = aws_s3_bucket.B2B_Project_bucket.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }

#===================================Upload files to S3====================================#
resource "aws_s3_object" "python_script" {
  for_each      = fileset(var.upload_directory, "**/*.*")
  bucket        = aws_s3_bucket.B2B_Project_bucket.bucket
  key           = replace(each.value, var.upload_directory, "")
  source        = "${var.upload_directory}${each.value}"
  etag          = filemd5("${var.upload_directory}${each.value}")
  content_type  = lookup(var.mime_types, split(".", each.value)[length(split(".", each.value)) - 1])
}
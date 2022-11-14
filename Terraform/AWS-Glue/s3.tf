#======================================CREATE S3==========================================#
  resource "aws_s3_bucket" "Export_DynamoDB" {
    bucket = "${var.name_bucket}-${var.name_env}"

      tags = {
      Name                      = "${var.backend_role}-${var.finance_env}"
      Role                      = "${var.backend_role}-${var.finance_env}"
      "EpicFinance:Environment" = var.finance_env
      "EpicFinance:Owner"       = var.finance_owner
   }
  }

  resource "aws_s3_bucket_public_access_block" "export" {
    bucket = aws_s3_bucket.Export_DynamoDB.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }

/*
  resource "aws_s3_bucket_policy" "allow_access_from_specific_role" {
    bucket = aws_s3_bucket.profile.id
    policy = data.aws_iam_policy_document.allow_access_from_specific_role.json
  }

  data "aws_iam_policy_document" "allow_access_from_specific_role" {
    statement {
      principals {
        type        = "AWS"
        identifiers = [var.aws_s3_role_arn]
      }

      actions = [
        "*",
      ]

      resources = [
        aws_s3_bucket.profile.arn,
      ]
    }
  }
*/



#===================================Upload files to S3====================================#
resource "aws_s3_object" "python_script" {
  for_each      = fileset(var.upload_directory, "**/*.*")
  bucket        = aws_s3_bucket.Export_DynamoDB.bucket
  key           = replace(each.value, var.upload_directory, "")
  source        = "${var.upload_directory}${each.value}"
  etag          = filemd5("${var.upload_directory}${each.value}")
  content_type  = lookup(var.mime_types, split(".", each.value)[length(split(".", each.value)) - 1])
}
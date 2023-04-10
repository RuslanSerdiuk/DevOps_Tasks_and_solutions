#======================================CREATE S3==========================================#
  resource "aws_s3_bucket" "B2B_Project_bucket" {
    bucket = "${var.name_bucket}-${var.name_env}"

      tags = {
        "Name"                    = var.finance_product
        "Role"                    = "${var.backend_role}-${var.name_env}"
        "Environment"             = var.finance_env
      }
  }

  resource "aws_s3_bucket_public_access_block" "export" {
    bucket = aws_s3_bucket.B2B_Project_bucket.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }

resource "aws_s3_bucket_policy" "allow_access" {
  bucket = aws_s3_bucket.B2B_Project_bucket.id
  policy = data.aws_iam_policy_document.allow_access.json
}

data "aws_iam_policy_document" "allow_access" {
  policy_id = "PolicyForCloudFrontPrivateContent"
  statement {
    sid       = "AllowCloudFrontServicePrincipal"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.B2B_Project_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.my_origin_access_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_acl" "Project_bucket" {
  bucket = aws_s3_bucket.B2B_Project_bucket.id
  acl    = "private"
}

/*
data "aws_iam_policy_document" "allow_access" {
  policy_id = "PolicyForCloudFrontPrivateContent"
  policy = <<EOF
{
    "Version": "2008-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "AllowCloudFrontServicePrincipal",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::mach-bst-frontend/*",
            "Condition": {
                "StringEquals": {
                    "AWS:SourceArn": "arn:aws:cloudfront::863151058727:distribution/E2TXCIXPU7WRQQ"
                }
            }
        }
    ]
}
EOF
}
*/
#===================================Upload files to S3====================================#
resource "aws_s3_object" "upload_objects" {
  for_each      = fileset(var.upload_directory, "**/*.*")
  bucket        = aws_s3_bucket.B2B_Project_bucket.bucket
  key           = replace(each.value, var.upload_directory, "")
  source        = "${var.upload_directory}${each.value}"
  etag          = filemd5("${var.upload_directory}${each.value}")
  content_type  = lookup(var.mime_types, split(".", each.value)[length(split(".", each.value)) - 1])
}
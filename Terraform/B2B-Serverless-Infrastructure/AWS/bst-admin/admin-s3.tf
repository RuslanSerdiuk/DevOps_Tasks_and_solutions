################################## S3 Bucket [Admin] ########################################
  resource "aws_s3_bucket" "B2B_Project_bucket_for_admin" {
    bucket = "${var.bucket_name}-${var.name_env}"

      tags = {
        "Name"                    = var.finance_product
        "Role"                    = "${var.backend_role}-${var.name_env}"
        "Environment"             = var.finance_env
      }
  }

  resource "aws_s3_bucket_public_access_block" "access_block_for_admin_bucket" {
    bucket = aws_s3_bucket.B2B_Project_bucket_for_admin.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }


resource "aws_s3_bucket_acl" "acl_for_admin_bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.ownership_control_for_b2b_acl_for_admin_bucket]

  bucket = aws_s3_bucket.B2B_Project_bucket_for_admin.id
  acl    = "private"
}

resource "aws_s3_bucket_ownership_controls" "ownership_control_for_b2b_acl_for_admin_bucket" {
  bucket = aws_s3_bucket.B2B_Project_bucket_for_admin.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


resource "aws_s3_bucket_policy" "allow_access_policy_for_admin_bucket" {
  bucket = aws_s3_bucket.B2B_Project_bucket_for_admin.id
  policy = data.aws_iam_policy_document.allow_access_policy_for_admin_bucket.json
}

data "aws_iam_policy_document" "allow_access_policy_for_admin_bucket" {
  policy_id = "PolicyForCloudFrontPrivateContent"
  statement {
    sid       = "PolicyForCloudFrontPrivateContent"
    effect    = "Allow"
    actions   = ["s3:GetObject"]

    resources = [
      "${aws_s3_bucket.B2B_Project_bucket_for_admin.arn}/*"
    ]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = ["${aws_cloudfront_distribution.s3_distribution_for_admin.arn}"]
    }
  }
}

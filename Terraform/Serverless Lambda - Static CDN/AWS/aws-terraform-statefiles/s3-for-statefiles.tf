####################################################################
#        Create an S3 Bucket to store the state file in
####################################################################
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.state_bucket_name
  object_lock_enabled = true
  
  lifecycle {
    prevent_destroy = false
  }
    tags = {
        "Name"                    = var.finance_product
        "Role"                    = "${var.backend_role}-${var.name_env}"
        "Environment"             = var.finance_env
      }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "acl_for_terraform_state_bucket" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "S3_access_block" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
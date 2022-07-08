#### [Simple Application](https://github.com/RuslanSerdiuk/DevOps_Tasks_and_solutions/tree/Terraform/Terraform/Simple_Application) - an example of how to deploy a simple application to AWS and the infrastructure for it using Terraform


#### Create DynamoDB and S3:
```
terraform {
  backend "s3" {
    bucket = "tf-ruslan-bucketfor-statefiles"
    key = "terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "tf-ruslan-state-locks"
    encrypt = true
  }
}


provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  
  region     = var.region
}


####################################################################
#        Create a DynamoDB Table for locking the state file
####################################################################
resource "aws_dynamodb_table" "terraform_state_locks" {
  name = var.dynamodb_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    name        = var.dynamodb_table
    description = "DynamoDB terraform table to lock states"
  }
}


####################################################################
#        Create an S3 Bucket to store the state file in
####################################################################
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.state_bucket
  object_lock_enabled = true
  
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name = var.state_bucket
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

resource "aws_s3_bucket_acl" "example" {
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
```


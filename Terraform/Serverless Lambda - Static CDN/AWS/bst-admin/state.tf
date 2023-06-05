terraform {
  backend "s3" {
    bucket = "tf-ruslan-bucketfor-statefiles"
    key = "bst-admin.tfstate"
    region = "us-east-2"
    workspace_key_prefix = "terraform-infrastructure/AWS"
  }
}

provider "aws" {
  region     = var.region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}
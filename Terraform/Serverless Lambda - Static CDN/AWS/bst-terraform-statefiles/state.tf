
terraform {
  backend "s3" {
    bucket = "mach-bst-infrastructure"
    key = "bst-infrastructure-aws-statelock.tfstate"
    region = "eu-central-1"
    workspace_key_prefix = "terraform-infrastructure/AWS"
  }
}

provider "aws" {
  region     = var.region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  token      = var.aws_session_token
}
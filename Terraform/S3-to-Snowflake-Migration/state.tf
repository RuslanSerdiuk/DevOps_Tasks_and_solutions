terraform {
  backend "s3" {
    bucket = "ton-tf-state"
    key    = "pns-com/pns-com-to-snowflake-migration.state"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"

  assume_role {
    role_arn = var.aws_role
  }
}
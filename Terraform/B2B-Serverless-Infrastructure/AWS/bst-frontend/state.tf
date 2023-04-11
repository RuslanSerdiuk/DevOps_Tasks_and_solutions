terraform {
  backend "s3" {
    bucket = "tf-ruslan-bucketfor-statefiles"
    key = "terraform-infrastructure/AWS/bst-frontend.tfstate"
    region = "us-east-2"
    dynamodb_table = "tf-ruslan-state-locks"
    encrypt = true
  }
}

provider "aws" {
  region     = var.region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}
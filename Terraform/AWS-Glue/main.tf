terraform {
  backend "local" {
    path = ".tfstate"
  }
}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  
  region     = var.region
}


module "s3" {
  source = "./module/S3"
  name        = "Serdiuk"
  name_bucket = "bucket-script-for-export-db-${var.region}"
}

module "Glue" {
  source = "./module/Glue"
  name   = "TEST-2"
  script_location = "s3://${module.s3.S3Bucket_id}/script.py"
}

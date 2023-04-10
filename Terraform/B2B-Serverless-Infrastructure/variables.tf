############################
# AWS                      #
############################

variable "aws_access_key_id" {
  default = ""
}

variable "aws_secret_access_key" {
  default = ""
}

variable "region" {
  type        = string
  description = "My Region"
}

variable "accountId" {
  
}

############################
# Tags                     #
############################

variable "backend_role" {

}

variable "finance_product" {
  description = "Name of the service"
}

variable "finance_env" {
  description = "Environment (dev|prod)"
}

variable "name_env" {
  description = "Short name env which will be used in resource name"
}

############################
# S3                       #
############################

variable "name_bucket" {

}

variable "upload_directory" {
  default = "S3Bucket_files/"
}

variable "mime_types" {
  default = {
    py   = "database/script.py"
    zip  = "lambda.zip"
    }
}

############################
# CloudFront               #
############################

variable "s3_origin" {
  
}

############################
# Lambda                   #
############################

variable "function_name" {

}

variable "role_for_lambda" {

}

variable "lambda_handler" {

}

variable "s3_key_file" {

}

############################
# API Gateway              #
############################

variable "api_name" {
  
}

variable "http_route_key" {
  description = "( $default | GET /pets | or ANY /example/{proxy+} )"
}
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

####### ENV Variables ######
variable "NODE_ENV" {}
variable "APP_NAME" {}
variable "APP_FALLBACK_LANGUAGE" {}
variable "APP_HEADER_LANGUAGE" {}
variable "FRONTEND_DOMAIN" {}
variable "AUTH_JWT_SECRET" {
  sensitive   = true
}
variable "AUTH_JWT_TOKEN_EXPIRES_IN" {
  sensitive   = true
}
variable "CTP_CLIENT_ID" {
  sensitive   = true
}
variable "CTP_PROJECT_KEY" {
  sensitive   = true
}
variable "CTP_CLIENT_SECRET" {
  sensitive   = true
}
variable "CTP_AUTH_URL" {}
variable "CTP_API_URL" {}
variable "CTP_SCOPES" {}
variable "ENCRYPTION_KEY" {
  sensitive   = true
}
variable "TOKEN_ENCRYPTION_ENABLED" {}
variable "GIT_COMMIT" {}
variable "GIT_BRANCH" {}
variable "GIT_TAGS" {}

############################
# API Gateway              #
############################

variable "api_name" {
  
}

variable "http_route_key" {
  description = "( $default | GET /pets | or ANY /example/{proxy+} )"
}
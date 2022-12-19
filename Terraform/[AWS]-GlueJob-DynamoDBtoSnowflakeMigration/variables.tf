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
  description = "Environment (ci|gamedev|prod)"
}

variable "name_env" {
  description = "Short name env which will be used in resource name"
}

variable "finance_owner" {
  description = "Finance owner"
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
# Glue                     #
############################

variable "job_name" {
  
}

variable "name_job_trigger" {
  
}

variable "role_arn" {
  
}

variable "script_name" {
  
}

########## ALARM ###########
variable "alarm_function_name" {
  
}
variable "alarm_function_handler" {
  
}
variable "alarm_function_file" {
  
}

############################
# Vault                    #
############################

variable "SNOWFLAKE_NOTIFICATIONS_DB" {}
variable "SNOWFLAKE_NOTIFICATIONS_USER" {}
variable "SNOWFLAKE_NOTIFICATIONS_PASSWORD" {}
variable "SNOWFLAKE_NOTIFICATIONS_SCHEMA" {}
variable "SNOWFLAKE_NOTIFICATIONS_WAREHOUSE" {}
variable "SNOWFLAKE_NOTIFICATIONS_ACCOUNT" {}

############################
# Secret Manager           #
############################
/*
variable "name_secret" {
  
}
*/
############################
# Lambda                   #
############################

variable "function_name" {
  
}

variable "role" {
  
}

variable "lambda_export_s3_to_snowflake_handler" {
  
}

variable "s3_key_file" {
  
}
/*
variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for instances and lb's"
}

variable "security_groups" {
  type        = list(string)
  description = "Securiy groups for instances and lb's"
}
*/
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

########## JOB: 1 ##########

variable "job_name" {
  description = "Name of the glue job"
}

variable "name_job_trigger" {

}

variable "role_arn" {
  description = "IAM Role for the glue job"
}

variable "script_name" {
  description = "Name of the Python script for the glue job"
}

########## JOB: 2 ##########

variable "job_2_name" {

}

variable "name_job_2_trigger" {

}

variable "job_2_script_name" {

}

########## JOB: 3 ##########

variable "job_3_name" {
  
}

variable "name_job_3_trigger" {
  
}

variable "job_3_script_name" {
  
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
variable "SLACK_URL" {}

############################
# Secret Manager           #
############################

variable "name_secret" {

}

/*
variable "name_secret_for_comm_service" {
  
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

##### Lambda 2: trigger export process ###
variable "function_2_name" {

}

variable "role_for_function_2" {

}

variable "lambda_trigger_export_s3_to_snowflake_handler" {

}

variable "s3_key_file_for_function_2" {

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

########## Lambda Alert to Slack ###########
variable "lambda_alarm_role" {

}

variable "alarm_function_name" {

}
variable "alarm_function_handler" {

}
variable "alarm_function_file" {

}

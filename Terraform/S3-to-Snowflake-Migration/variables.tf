############################
# AWS                      #
############################
/*
variable "atlantis_user" {
  default = ""
}

variable "aws_role" {
  description = "Role which will be assumed in order to work with oldprod account"
}
*/
variable "aws_access_key_id" {
  default = ""
}

variable "aws_secret_access_key" {
  default = ""
}

variable "region" {
  
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
# Vault                    #
############################
/*
variable "SNOWFLAKE_NOTIFICATIONS_DB" {}
variable "SNOWFLAKE_NOTIFICATIONS_USER" {}
variable "SNOWFLAKE_NOTIFICATIONS_PASSWORD" {}
*/
############################
# Secret Manager           #
############################

variable "name_secret" {
  
}
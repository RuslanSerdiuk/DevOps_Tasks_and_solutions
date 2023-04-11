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

variable "backend_role_frontend" {

}

variable "backend_role_admin" {
  
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

variable "frontend_name_bucket" {

}

variable "admin_name_bucket" {
  
}

############################
# CloudFront               #
############################

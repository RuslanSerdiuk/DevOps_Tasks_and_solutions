############################
# Tags                     #
############################
variable "backend_role" {}
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
# Storage                  #
############################
variable "storage_bucket_name" {}
variable "location" {}
variable "storage_class" {}

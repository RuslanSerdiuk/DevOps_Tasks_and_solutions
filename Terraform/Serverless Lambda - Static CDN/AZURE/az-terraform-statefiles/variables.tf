############################
# Azure                    #
############################

variable "rg_name" {
  description = "name of the resource group"
}

variable "rg_location" {
  description = "location of the resource group"
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
# Storage                  #
############################
variable "storage_account_name" {
  
}

variable "account_tier" {
  
}

variable "storage_container_name" {
  
}
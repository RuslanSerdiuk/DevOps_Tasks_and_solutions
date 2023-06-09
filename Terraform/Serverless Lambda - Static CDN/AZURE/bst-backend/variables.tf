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
# Lambda                   #
############################

variable "storage_account_name" {

}

variable "account_tier" {

}

variable "service_plan_name" {

}

variable "application_insights_name" {
  
}

variable "os_type" {

}

variable "function_name" {

}

variable "storage_with_package" {
  
}

####### ENV Variables ######
variable "NODE_ENV" {}
variable "APP_NAME" {}
variable "APP_FALLBACK_LANGUAGE" {}
variable "APP_HEADER_LANGUAGE" {}
variable "FRONTEND_DOMAIN" {}
variable "AUTH_JWT_SECRET" {
  sensitive = true
}
variable "AUTH_JWT_TOKEN_EXPIRES_IN" {
  sensitive = true
}
variable "CTP_CLIENT_ID" {
  sensitive = true
}
variable "CTP_PROJECT_KEY" {
  sensitive = true
}
variable "CTP_CLIENT_SECRET" {
  sensitive = true
}
variable "CTP_AUTH_URL" {}
variable "CTP_API_URL" {}
variable "CTP_SCOPES" {}
variable "ENCRYPTION_KEY" {
  sensitive = true
}
variable "TOKEN_ENCRYPTION_ENABLED" {}
variable "GIT_COMMIT" {}
variable "GIT_BRANCH" {}
variable "GIT_TAGS" {}

variable "MAIL_CLIENT_PORT" {}
variable "MAIL_DEFAULT_EMAIL" {}
variable "MAIL_DEFAULT_NAME" {}
variable "MAIL_HOST" {}
variable "MAIL_IGNORE_TLS" {}
variable "MAIL_PASSWORD" {
  sensitive = true
}
variable "MAIL_PORT" {}
variable "MAIL_REQUIRE_TLS" {}
variable "MAIL_SECURE" {}
variable "MAIL_USER" {}
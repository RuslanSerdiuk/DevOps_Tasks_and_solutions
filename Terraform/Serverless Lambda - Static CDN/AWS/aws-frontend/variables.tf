############################
# AWS                      #
############################

variable "aws_access_key_id" {
  default = ""
}

variable "aws_secret_access_key" {
  default = ""
}

variable "aws_session_token" {}

variable "region" {
  type        = string
  description = "My Region"
}

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
# CloudFront               #
############################

variable "default_root_object" {}

variable "prefix_logging_group" {}

variable "protocol_policy" {}

variable "cache_policy_id" {}

variable "resp_head_policy_id" {}

variable "cache_allowed_methods" {}

variable "cached_methods" {}

### CustomErrorResponse ###
variable "error_code" {}

variable "response_code" {}

variable "response_page_path" {}

variable "error_caching_min_ttl" {}

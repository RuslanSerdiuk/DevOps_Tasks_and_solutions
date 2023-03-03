variable "access_key" {
  type        = string
  description = "access_key"
}

variable "secret_key" {
  type        = string
  description = "secret_key"
}

variable "region" {
  type        = string
  description = "My Region"
}

variable "state_bucket" {
  type = string
  default = "tf-ruslan-bucketfor-statefiles"
}

variable "dynamodb_table" {
  description = "DynamoDB table for locking Terraform states"
  type = string
  default = "tf-ruslan-state-locks"
}

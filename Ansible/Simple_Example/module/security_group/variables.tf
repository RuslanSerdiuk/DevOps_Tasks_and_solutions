variable "cidr_blocks_HTTP_HTTPS" {
  type        = list(string)
  description = "Cidr_Block_your_HTTP_and_HTTPS"
  default     = ["159.224.64.243/32", "89.162.139.28/32", "89.162.139.29/32", "89.162.139.30/32", "178.215.245.53/32", "85.223.209.18/32"]
}

variable "cidr_blocks_SSH" {
  type        = list(string)
  description = "Cidr_Block_your_SHH_Connection"
  default     = ["10.27.0.0/20", "89.162.139.28/32", "89.162.139.29/32", "89.162.139.30/32", "178.215.245.53/32", "85.223.209.18/32"]
}

variable "cidr_blocks_DB" {
  type = list(string)
  description = "Cidr_Block_your_Connection_to_DB"
  default     = ["10.27.0.0/20"]
}

variable "vpc_id_security_groups" {
  description = "VPC_for_your_Security_Groups"
}

variable "name" {
  description = "Name_Your_Resources"
}

variable "name_group_for_web_connect" {
  description = "Name_Group_for_HTTP_and_HTTPS_inbound/outbound_traffic"
}

variable "name_group_for_ssh_connect" {
  description = "Name_Group_for_SSH_inbound/outbound_traffic"
}

variable "name_group_for_db_connect" {
  description = "Name_Group_for_DB_Connection"
}
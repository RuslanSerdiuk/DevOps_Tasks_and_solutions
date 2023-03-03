variable "cidr_blocks_default_port" {
  type        = list(string)
  description = "Cidr Block MongoDB Default Port"
  default     = ["159.224.64.243/32", "89.162.139.28/32", "89.162.139.29/32", "89.162.139.30/32", "178.215.245.53/32", "85.223.209.18/32"]
}

variable "cidr_blocks_SSH" {
  type        = list(string)
  description = "Cidr Block your SHH Connection"
  default     = ["10.27.0.0/20", "89.162.139.28/32", "89.162.139.29/32", "89.162.139.30/32", "178.215.245.53/32", "85.223.209.18/32"]
}

variable "vpc_id_security_groups" {
  description = "VPC for your Security Groups"
}

variable "name" {
  description = "Name Your Resources"
}

variable "name_group_for_mongo_connect" {
  description = "Name Group for MongoDB inbound/outbound traffic"
}

variable "name_group_for_ssh_connect" {
  description = "Name Group for Ansible and MongoDB SSH Connection"
}

variable "mongodb_cluster_public_ip" {
  description = "Public IP of MongoDB Cluster"
}
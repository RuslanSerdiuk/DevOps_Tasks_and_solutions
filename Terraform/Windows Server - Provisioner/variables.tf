############################
# AWS Creds                #
############################
  variable "aws_access_key_id" {
    type        = string
    description = "access_key"
  }

  variable "aws_secret_access_key" {
    type        = string
    description = "secret_key"
  }

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
# Key-Pair                 #
############################
  variable key_name {}

############################
# VPC                      #
############################
  # AWS AZ
  variable "aws_az" {
    type        = string
    description = "AWS AZ"
    default     = "us-east-2a"
  }
  # VPC Variables
  variable "vpc_cidr" {
    type        = string
    description = "CIDR for the VPC"
    default     = "10.1.64.0/18"
  }
  # Subnet Variables
  variable "public_subnet_cidr" {
    type        = string
    description = "CIDR for the public subnet"
    default     = "10.1.64.0/24"
  }

############################
# EC2                      #
############################
  variable "windows_instance_type" {
    type        = string
    description = "EC2 instance type for Windows Server"
    default     = "t2.micro"
  }
  variable "windows_associate_public_ip_address" {
    type        = bool
    description = "Associate a public IP address to the EC2 instance"
    default     = true
  }
  variable "windows_root_volume_size" {
    type        = number
    description = "Volumen size of root volumen of Windows Server"
    default     = "30"
  }
  variable "windows_data_volume_size" {
    type        = number
    description = "Volumen size of data volumen of Windows Server"
    default     = "10"
  }
  variable "windows_root_volume_type" {
    type        = string
    description = "Volumen type of root volumen of Windows Server."
    default     = "gp2"
  }
  variable "windows_data_volume_type" {
    type        = string
    description = "Volumen type of data volumen of Windows Server."
    default     = "gp2"
  }
  variable "windows_instance_name" {
    type        = string
    description = "EC2 instance name for Windows Server"
    default     = "windows_server"
  }


############################
# Security Group           #
############################
  variable "security_group_name" {}


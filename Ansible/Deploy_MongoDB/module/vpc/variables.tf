variable "name" {
    description = "name_your_VPC"
    default = "Ruslan_Serdiuk"
}

variable "ansible_vpc_cidr_block" {
    description = "Cidr_your_VPC"
    default     = "10.27.0.0/20"
}

variable "ansible_cidr_block_public_subnet_b" {
    description = "Cidr_your_Public_Subnet_B"
    default     = "10.27.1.0/24"
}

variable "availability_zone_public_subnet_b" {
    description = "Zone_your_Public_Subnet_B"
    default     = "us-east-2b"
}

variable "ansible_cidr_block_public_subnet_a" {
    description = "Cidr_your_Public_Subnet_A"
    default     = "10.27.2.0/24"
}

variable "availability_zone_public_subnet_a" {
    description = "Zone_your_Public_Subnet_A"
    default     = "us-east-2a"
}
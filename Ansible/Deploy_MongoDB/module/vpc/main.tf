data "aws_availability_zones" "available" {}

#========================VPC======================================================#
  resource "aws_vpc" "TF_Ansible" {
    cidr_block           = var.ansible_vpc_cidr_block
    enable_dns_hostnames = true
    tags = {
      Name = "${var.name}_TF_Ansible"
    }
  }


#======================SUBNETS====================================================#
  resource "aws_subnet" "TF_Ansible_Public_Subnet_B" {
    vpc_id                  = aws_vpc.TF_Ansible.id
    cidr_block              = var.ansible_cidr_block_public_subnet_b
    availability_zone       = var.availability_zone_public_subnet_b
    map_public_ip_on_launch = true
    tags = {
      Name = "${var.name}_TF_Ansible_Public_Subnet_B"
    }
  }

  resource "aws_subnet" "TF_Ansible_Public_Subnet_A" {
    vpc_id                  = aws_vpc.TF_Ansible.id
    cidr_block              = var.ansible_cidr_block_public_subnet_a
    availability_zone       = var.availability_zone_public_subnet_a
    map_public_ip_on_launch = true
    tags = {
      Name = "${var.name}_TF_Ansible_Public_Subnet_A"
    }
  }


#======================GATEWAY====================================================#
  resource "aws_internet_gateway" "TF_Ansible_Network_Gateway" {
    vpc_id = aws_vpc.TF_Ansible.id

    tags = {
      Name = "${var.name}_TF_Ansible_Network_Gateway"
    }
  }


#====================ROUTE TABLE==================================================#
  #=========Public=============#
    resource "aws_route_table" "TF_Ansible_Public_Route_Table_B" {
      vpc_id = aws_vpc.TF_Ansible.id

      route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.TF_Ansible_Network_Gateway.id
      }

      tags = {
        Name = "${var.name}_TF_Ansible_Public_Route_Table_B"
      }
    }

    resource "aws_route_table_association" "Public-B" {
      subnet_id = aws_subnet.TF_Ansible_Public_Subnet_B.id
      route_table_id = aws_route_table.TF_Ansible_Public_Route_Table_B.id
    }


    resource "aws_route_table" "TF_Ansible_Public_Route_Table_A" {
      vpc_id = aws_vpc.TF_Ansible.id

      route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.TF_Ansible_Network_Gateway.id
      }

      tags = {
        Name = "${var.name}_TF_Ansible_Public_Route_Table_A"
      }
    }

    resource "aws_route_table_association" "Public-A" {
      subnet_id = aws_subnet.TF_Ansible_Public_Subnet_A.id
      route_table_id = aws_route_table.TF_Ansible_Public_Route_Table_A.id
    }
  #
#
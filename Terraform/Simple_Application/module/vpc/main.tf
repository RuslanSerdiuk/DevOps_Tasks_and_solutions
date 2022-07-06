data "aws_availability_zones" "available" {}

#========================VPC======================================================#
  resource "aws_vpc" "TF_EPAM" {
    cidr_block           = var.cidr_block_vpc
    enable_dns_hostnames = true
    tags = {
      Name = "${var.name}_TF_EPAM"
    }
  }


#======================SUBNETS====================================================#
  resource "aws_subnet" "TF_EPAM_Public_Subnet_B" {
    vpc_id                  = aws_vpc.TF_EPAM.id
    cidr_block              = var.cidr_block_public_subnet_b
    availability_zone       = var.availability_zone_public_subnet_b
    map_public_ip_on_launch = true
    tags = {
      Name = "${var.name}_TF_EPAM_Public_Subnet_B"
    }
  }

  resource "aws_subnet" "TF_EPAM_Public_Subnet_A" {
    vpc_id                  = aws_vpc.TF_EPAM.id
    cidr_block              = var.cidr_block_public_subnet_a
    availability_zone       = var.availability_zone_public_subnet_a
    map_public_ip_on_launch = true
    tags = {
      Name = "${var.name}_TF_EPAM_Public_Subnet_A"
    }
  }

  resource "aws_subnet" "TF_EPAM_Privat_Subnet_B" {
    vpc_id                                      = aws_vpc.TF_EPAM.id
    cidr_block                                  = var.cidr_block_privat_subnet_b
    availability_zone                           = var.availability_zone_privat_subnet_b
    enable_resource_name_dns_a_record_on_launch = true
    tags = {
      Name = "${var.name}_TF_EPAM_Privat_Subnet_B"
    }
  }

  resource "aws_subnet" "TF_EPAM_Privat_Subnet_A" {
    vpc_id                                      = aws_vpc.TF_EPAM.id
    cidr_block                                  = var.cidr_block_privat_subnet_a
    availability_zone                           = var.availability_zone_privat_subnet_a
    enable_resource_name_dns_a_record_on_launch = true
    tags = {
      Name = "${var.name}_TF_EPAM_Privat_Subnet_A"
    }
  }


#====================ELASTIC IP===================================================#
  resource "aws_eip" "TF_EPAM_ElIP" {
    vpc = true

    depends_on                = [aws_internet_gateway.TF_EPAM_Network_Gateway]
    tags = {
      Name = "${var.name}_TF_EPAM_ElIP"
    }
  }


#======================GATEWAY====================================================#
  resource "aws_internet_gateway" "TF_EPAM_Network_Gateway" {
    vpc_id = aws_vpc.TF_EPAM.id

    tags = {
      Name = "${var.name}_TF_EPAM_Network_Gateway"
    }
  }


  resource "aws_nat_gateway" "TF_EPAM_NAT" {
    allocation_id = aws_eip.TF_EPAM_ElIP.id
    subnet_id     = aws_subnet.TF_EPAM_Public_Subnet_B.id

    tags = {
      Name = "${var.name}_TF_EPAM_NAT"
    }

    depends_on = [aws_internet_gateway.TF_EPAM_Network_Gateway]
  }


#====================ROUTE TABLE==================================================#
  #=========Public=============#
    resource "aws_route_table" "TF_EPAM_Public_Route_Table_B" {
      vpc_id = aws_vpc.TF_EPAM.id

      route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.TF_EPAM_Network_Gateway.id
      }

      tags = {
        Name = "${var.name}_TF_EPAM_Public_Route_Table_B"
      }
    }

    resource "aws_route_table_association" "Public-B" {
      subnet_id = aws_subnet.TF_EPAM_Public_Subnet_B.id
      route_table_id = aws_route_table.TF_EPAM_Public_Route_Table_B.id
    }


    resource "aws_route_table" "TF_EPAM_Public_Route_Table_A" {
      vpc_id = aws_vpc.TF_EPAM.id

      route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.TF_EPAM_Network_Gateway.id
      }

      tags = {
        Name = "${var.name}_TF_EPAM_Public_Route_Table_A"
      }
    }

    resource "aws_route_table_association" "Public-A" {
      subnet_id = aws_subnet.TF_EPAM_Public_Subnet_A.id
      route_table_id = aws_route_table.TF_EPAM_Public_Route_Table_A.id
    }



  #=========Privat=============#
    resource "aws_route_table" "TF_EPAM_Privat_Route_Table_B" {
      vpc_id = aws_vpc.TF_EPAM.id

      route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.TF_EPAM_NAT.id
      }

      tags = {
        Name = "${var.name}_TF_EPAM_Privat_Route_Table_B"
      }
    }

    resource "aws_route_table_association" "Privat_B" {
      subnet_id = aws_subnet.TF_EPAM_Privat_Subnet_B.id
      route_table_id = aws_route_table.TF_EPAM_Privat_Route_Table_B.id
    }



    resource "aws_route_table" "TF_EPAM_Privat_Route_Table_A" {
      vpc_id = aws_vpc.TF_EPAM.id

      route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.TF_EPAM_NAT.id
      }

      tags = {
        Name = "${var.name}_TF_EPAM_Privat_Route_Table_A"
      }
    }

    resource "aws_route_table_association" "Privat_A" {
      subnet_id = aws_subnet.TF_EPAM_Privat_Subnet_A.id
      route_table_id = aws_route_table.TF_EPAM_Privat_Route_Table_A.id
    }



#=====================ENDPOINT FOR S3=============================================#
  resource "aws_vpc_endpoint" "tf-s3-endpoint" {
    vpc_id       = aws_vpc.TF_EPAM.id
    service_name = "com.amazonaws.us-east-2.s3"
    tags = {
      Name = "${var.name}_TF_Endpoint"
    }
  }
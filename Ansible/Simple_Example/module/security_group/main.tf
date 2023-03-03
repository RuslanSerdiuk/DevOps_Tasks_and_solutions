#===================SECURITY GROUP================================================#
  resource "aws_security_group" "TF_Ansible" {
    name        = "${var.name}_${var.name_group_for_web_connect}"
    description = "TLS_and_HTTP_inbound/outbound_traffic"
    vpc_id      = var.vpc_id_security_groups

    dynamic "ingress" {
        for_each = ["80", "443"]
      content {
        description      = "Traffic from VPC"
        from_port        = ingress.value
        to_port          = ingress.value
        protocol         = "tcp"
        cidr_blocks      = var.cidr_blocks_HTTP_HTTPS
      }
    }

    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }

    tags = {
      Name = "${var.name}_TF_Ansible_HTTP_HTTPS_Connection"
    }
  }


  resource "aws_security_group" "TF_Ansible_SSH_Connection" {
    name        = "${var.name}_${var.name_group_for_ssh_connect}"
    description = "SSH_inbound/outbound_traffic"
    vpc_id      = var.vpc_id_security_groups

    ingress {
      description      = "SSH Connect"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = var.cidr_blocks_SSH
    }

    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }

    tags = {
      Name = "${var.name}_TF_Ansible_SSH_Connection"
    }
  }


  resource "aws_security_group" "TF_Ansible_DB" {
    name        = "${var.name}_${var.name_group_for_db_connect}"
    description = "TF_Ansible_DB_Connection"
    vpc_id      = var.vpc_id_security_groups

    ingress {
      description = "All trafic in VPC"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = var.cidr_blocks_DB
    }

    egress {
      description = "All trafic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "${var.name}_TF_Ansible_DB_Connection"
    }
  }

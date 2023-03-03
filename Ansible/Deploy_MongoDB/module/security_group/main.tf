#=================== SECURITY GROUPs ================================================#
  resource "aws_security_group" "TF_MongoDB_Ports" {
    name        = "${var.name}_${var.name_group_for_mongo_connect}"
    description = "MongoDB_inbound/outbound_traffic"
    vpc_id      = var.vpc_id_security_groups

    dynamic "ingress" {
        for_each = ["27017", "27018"]
      content {
        description      = "Traffic from VPC"
        from_port        = ingress.value
        to_port          = ingress.value
        protocol         = "tcp"
        cidr_blocks      = var.cidr_blocks_default_port
      }
    }

    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }

    tags = {
      Name = "${var.name}_TF_MongoDB_Connection"
    }
  }


  resource "aws_security_group" "TF_Ansible_Mongo_SSH_Connection" {
    name        = "${var.name}_${var.name_group_for_ssh_connect}"
    description = "Ansible_and_MongoDB_SSH_Connection"
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
      Name = "${var.name}_TF_Ansible_MongoDB_SSH_Connection"
    }
  }

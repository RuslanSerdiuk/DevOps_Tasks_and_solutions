provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  
  region     = var.region
}

####################################################################
#                       All my modules
####################################################################


module "vpc" {
  source = "./module/vpc"

  name                               = "Serdiuk"
  ansible_vpc_cidr_block             = "10.27.0.0/20"

  ansible_cidr_block_public_subnet_b = "10.27.1.0/24"
  availability_zone_public_subnet_b  = "us-east-2b"

  ansible_cidr_block_public_subnet_a = "10.27.2.0/24"
  availability_zone_public_subnet_a  = "us-east-2a"
}

module "security_groups" {
  source = "./module/security_group"

  name                             = "Serdiuk"
  vpc_id_security_groups           = module.vpc.vpc_id

  name_group_for_mongo_connect     = "TF_MongoDB_Default_Port"
  cidr_blocks_default_port         = ["0.0.0.0/0"]
  
  name_group_for_ssh_connect       = "TF_Ansible_and_MongoDB_SSH_Connection"
  cidr_blocks_SSH                  = ["10.27.0.0/20", "188.163.60.177/32", "85.223.209.18/32"]

  mongodb_cluster_public_ip        = module.ec2.aws_mongodb_Cluster_public_ip
}

module "ec2" {
  source = "./module/EC2"
  vpc_public_subnets_b_id_ec2       = module.vpc.public_subnets_b
  security_group_ec2_id_mongo_ports = module.security_groups.MongoDB_Ports_id
  security_group_ec2_id_ssh         = module.security_groups.SSH_Connection_id
 
  private_ip_mongodb_primary_node   = module.ec2.mongogb_primary_node_private_ip
  private_ip_mongodb_secondary_node = module.ec2.mongogb_secondary_node_private_ip

  instance_type_Ansible_server      = "t2.micro"
  instance_type_mongodb_cluster     = "t2.micro"

  key_name_instance                 = "Ansible"
  aws_mongodb_cluster               = ["Primary_Node", "Secondary_Node"]
  aws_ansible_server                = "Ansible_Server"

  aws_access_key                    = var.access_key
  aws_secret_key                    = var.secret_key

  ssh_pub_key                       = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC31w4H26HYD/iEPSnzy1uSBCyY+ZlAWVMS1ZLkh9qTDP9Yi7ZmzGeuqys7NPWa+KBoSwCqWAVUYxGR5ul26vPHJGJwdjMvuYiDArhdetfbiMljnG0SxOuqApZxVJNuCYH6Q7XUe2oh4FsWSDiFZFnA+0sum/kFwstc10OfRYMJtXqKhN24UcwimjOIQN/tIip2lRyI5f+CefvrLBm7J9HC8GT6GDYrTdiCiD6FjtSleL2lYMDsHM70RtvRDfkrCrv45qG+v3UYmxlYmyDLgeJGs739j4YEXGBWL3bRP2+T+y3p1gFYVCwtzSMwwE4HqrGl9gfn/Z2W0LZTEwLSXyNnMf9Y2+oBLSkV6mThTlrCK47pXeBC07cdYMhpSm/o4hTRe5qkD3ye4kJ16BBRIeYlKeNdZ2Tw+w1hVOjE+duM4+YwXuG6/sh7AgT3pZykjl8ZtCl3QTLmWz1Ug3fB6M5f71ek6igdctdn528gNW+3R4Fmab2AljWF8cL1XWYsGxE= epam\ruslan_serdiuk@EPUAKHAW07C2"
}

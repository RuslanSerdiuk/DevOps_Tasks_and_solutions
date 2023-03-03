terraform {
  backend "s3" {
    bucket = "tf-ruslan-bucketfor-statefiles"
    key = "terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "tf-ruslan-state-locks"
    encrypt = true
  }
}


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
  cidr_block_vpc                    = "10.25.0.0/20"
  name                              = "Serdiuk"

  cidr_block_public_subnet_b        = "10.25.1.0/24"
  availability_zone_public_subnet_b = "us-east-2b"

  cidr_block_public_subnet_a        = "10.25.2.0/24"
  availability_zone_public_subnet_a = "us-east-2a"

  cidr_block_privat_subnet_b        = "10.25.3.0/24"
  availability_zone_privat_subnet_b = "us-east-2b"

  cidr_block_privat_subnet_a        = "10.25.4.0/24"
  availability_zone_privat_subnet_a = "us-east-2a"
}

module "security_groups" {
  source = "./module/security_group"
  name                        = "Serdiuk"
  vpc_id_security_groups      = module.vpc.vpc_id

  cidr_blocks_HTTP_HTTPS      = ["159.224.64.243/32", "89.162.139.28/32", "89.162.139.29/32", "89.162.139.30/32", "178.215.245.53/32"]
  cidr_blocks_SSH             = ["10.25.0.0/20", "89.162.139.28/32", "89.162.139.29/32", "89.162.139.30/32", "178.215.245.53/32"]

  cidr_blocks_RDS             = ["10.25.0.0/20"]
}

module "s3" {
  source = "./module/S3"
  name        = "Serdiuk"
  name_bucket = "tfruslaninepam"
}

module "database" {
  name                          = "Serdiuk"
  source = "./module/RDS"
  vpc_public_subnets_a_id       = module.vpc.public_subnets_a
  vpc_public_subnets_b_id       = module.vpc.public_subnets_b
  security_group_database_id    = module.security_groups.TF_EPAM_RDS_id

  db_allocated_storage          = 10
  type_db                       = "mysql"
  version_db                    = "8.0.27"
  db_instance_class             = "db.t2.micro"
  database_name                 = "php_mysql_crud"
  db_username                   = "admin"
  db_password                   = "password123"
  db_port                       = 3306
  db_identity                   = "tf-database"
}

module "asg" {
  source = "./module/ASG"
  name                          = "Serdiuk"
  security_group_asg_id_rds     = module.security_groups.TF_EPAM_RDS_id
  security_group_asg_id_bastion = module.security_groups.TF_Bastion_id
  security_group_ec2_id_ssh     = module.security_groups.SSH_Connection_id
  vpc_id_asg                    = module.vpc.vpc_id
  vpc_public_subnets_a_id_asg   = module.vpc.public_subnets_a
  vpc_public_subnets_b_id_asg   = module.vpc.public_subnets_b
  vpc_private_subnets_a_id_asg  = module.vpc.private_subnets_a
  vpc_private_subnets_b_id_asg  = module.vpc.private_subnets_b
  database_addr                 = module.database.RDS_Endpoint
  s3_addr                       = module.s3.S3Bucket_id

  launch_instance_type          = "t2.micro"
  path_user_data                = "./module/ASG/user_data.sh.tftpl"
  launch_key_name               = "Ruslan-key-Ohio-TASK2.2"
  db_name                       = module.database.database_name
  db_user_name                  = module.database.username
  db_pswd                       = module.database.password

  type_of_load_balancer         = "application"

  type_health_check             = "EC2"
}

module "route53" {
  source = "./module/Route53"
  route_balancer_dns_name       = module.asg.TF_Balancer_dns_name
  route_balancer_zone_id        = module.asg.TF_Balancer_zone_id
  my_domain                     = "tfruslaninepam.pp.ua"
}

module "ec2" {
  source = "./module/EC2"
  name                          = "Serdiuk"
  vpc_public_subnets_b_id_ec2   = module.vpc.public_subnets_b
  security_group_ec2_id_bastion = module.security_groups.TF_Bastion_id
  security_group_ec2_id_ssh     = module.security_groups.SSH_Connection_id

  bastion_instance_type         = "t2.micro"
  bastion_key_name              = "Ruslan-key-Ohio-TASK2.2"
  path_bastion_user_data        = "./module/EC2/key_for_bastion.sh.tftpl"
  public_key                    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC31w4H26HYD/iEPSnzy1uSBCyY+ZlAWVMS1ZLkh9qTDP9Yi7ZmzGeuqys7NPWa+KBoSwCqWAVUYxGR5ul26vPHJGJwdjMvuYiDArhdetfbiMljnG0SxOuqApZxVJNuCYH6Q7XUe2oh4FsWSDiFZFnA+0sum/kFwstc10OfRYMJtXqKhN24UcwimjOIQN/tIip2lRyI5f+CefvrLBm7J9HC8GT6GDYrTdiCiD6FjtSleL2lYMDsHM70RtvRDfkrCrv45qG+v3UYmxlYmyDLgeJGs739j4YEXGBWL3bRP2+T+y3p1gFYVCwtzSMwwE4HqrGl9gfn/Z2W0LZTEwLSXyNnMf9Y2+oBLSkV6mThTlrCK47pXeBC07cdYMhpSm/o4hTRe5qkD3ye4kJ16BBRIeYlKeNdZ2Tw+w1hVOjE+duM4+YwXuG6/sh7AgT3pZykjl8ZtCl3QTLmWz1Ug3fB6M5f71ek6igdctdn528gNW+3R4Fmab2AljWF8cL1XWYsGxE= epam\ruslan_serdiuk@EPUAKHAW07C2"
}

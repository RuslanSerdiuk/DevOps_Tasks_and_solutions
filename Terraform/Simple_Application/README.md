# TERRAFORM - Task-01

> **I was decided to create and write my own modules.**

#### All my modules:
- [vpc](https://git.epam.com/ruslan_serdiuk/devops-21q4-22q1-serdiuk-ruslan/-/tree/m8-TERRAFORM-Task-01/Module-08_Terraform/Task-01/module/vpc)
- [security groups](https://git.epam.com/ruslan_serdiuk/devops-21q4-22q1-serdiuk-ruslan/-/tree/m8-TERRAFORM-Task-01/Module-08_Terraform/Task-01/module/security_group)
- [S3](https://git.epam.com/ruslan_serdiuk/devops-21q4-22q1-serdiuk-ruslan/-/tree/m8-TERRAFORM-Task-01/Module-08_Terraform/Task-01/module/S3)
- [RDS](https://git.epam.com/ruslan_serdiuk/devops-21q4-22q1-serdiuk-ruslan/-/tree/m8-TERRAFORM-Task-01/Module-08_Terraform/Task-01/module/RDS)
- [ASG](https://git.epam.com/ruslan_serdiuk/devops-21q4-22q1-serdiuk-ruslan/-/tree/m8-TERRAFORM-Task-01/Module-08_Terraform/Task-01/module/ASG)
- [Route53](https://git.epam.com/ruslan_serdiuk/devops-21q4-22q1-serdiuk-ruslan/-/tree/m8-TERRAFORM-Task-01/Module-08_Terraform/Task-01/module/Route53)
- [EC2](https://git.epam.com/ruslan_serdiuk/devops-21q4-22q1-serdiuk-ruslan/-/tree/m8-TERRAFORM-Task-01/Module-08_Terraform/Task-01/module/EC2)

> **I put each module in a separate folder and access it with "source" in the root module.**

## _PART 1_
### But before that, I created an s3 Bucket to safe my .tfstate file remotely and DynamoDB to lock that file.
```
####################################################################
#        Create a DynamoDB Table for locking the state file
####################################################################
resource "aws_dynamodb_table" "terraform_state_locks" {
  name = var.dynamodb_table
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    name        = var.dynamodb_table
    description = "DynamoDB terraform table to lock states"
  }
}


####################################################################
#        Create an S3 Bucket to store the state file in
####################################################################
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.state_bucket
  object_lock_enabled = true
  
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name = var.state_bucket
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.terraform_state.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "S3_access_block" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
```
### After initialization I added to my code next:
```
terraform {
  backend "s3" {
    bucket = "tf-ruslan-backetfor-statefiles"
    key = "terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "tf-ruslan-state-locks"
    encrypt = true
  }
}
```
> **It enabled me migrate .tfstate file to s3 and lock it.**

## _PART 2_

### Now install the module by running "terraform get".

```
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
```

That is, using this solution, you need to replace `public_key` with your own

### And running "terraform apply" command for start create my infrastructure in AWS

## + _Plus_
> **A list the useful commands in terraform that helped me during work task:**
> > + `terraform taint` - for marker resource.
> > + `terraform apply -replace <your resource>` - replace resource.
> > + `terraform fmt -check -recursive .` - show all files that not clean code.
> > + `terraform fmt -recursive .` - formatted your code in all files.
> > + `terraform validate` - verify that the configuration files are syntactically valid.
> > + `terraform apply --auto-approve` - skips interactive approval of plan before applying.
> > + `terraform apply -lock=false ` - It enable don't hold a state lock during the operation. This is dangerous if others might concurrently run commands against the same workspace.
> > + `terraform force-unlock <resource id>` - If the previous process was interrupted and the state file was locked

### _Official documentation was used for this assignment:_
+ _https://www.terraform.io/cli/commands/import#example-import-into-resource_
+ _https://www.terraform-best-practices.com/v/uk/key-concepts_
+ _https://learn.hashicorp.com/tutorials/terraform/aws-variables?in=terraform/aws-get-started_
+ _https://learn.hashicorp.com/tutorials/terraform/install-cli_
+ _https://learn.acloud.guru/course/hashicorp-certified-terraform-associate-1/dashboard_
+ _https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_
+ _https://www.terraform.io/cli/config/environment-variables_
+ _https://www.terraform.io/language/values/variables_
+ _https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest_
+ _https://learn.hashicorp.com/tutorials/terraform/module?in=terraform/modules_
+ _https://learn.hashicorp.com/tutorials/terraform/module-create?in=terraform/modules_

### _Also I used unofficial sources:_
+ _https://adamtheautomator.com/upload-file-to-s3/_
+ _https://towardsdatascience.com/terraform-101-d51437a3170_
+ _https://www.youtube.com/watch?v=R1lpNVyCkwI&list=PLg5SS_4L6LYujWDTYb-Zbofdl44Jxb2l8&index=9_
+ _https://www.youtube.com/watch?v=Qwy-C5seMS8&list=PL8HowI-L-3_9bkocmR3JahQ4Y-Pbqs2Nt&index=8_
+ _https://www.youtube.com/watch?v=blR0hp_jQY8&list=PL3SzV1_k2H1UIUQMSdH1hEeuRydEGHeen&index=2_
+ _https://www.youtube.com/watch?v=lC4948SizsU_


### _Also you can check main.tf [HERE](https://git.epam.com/ruslan_serdiuk/devops-21q4-22q1-serdiuk-ruslan/-/blob/m8-TERRAFORM-Task-01/Module-08_Terraform/Task-01/main.tf)_
data "aws_ami" "latest_amazon" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}


data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

##########################################################################
#                            DATA ANSIBLE                                #
##########################################################################
  data "tls_public_key" "private_key" {
    private_key_pem = "${file("./module/EC2/Ruslan-key-Ohio-TASK22.pem")}"
  }

  data "local_file" "task_db" {
      filename = "./ansible/roles/deploy_db/tasks/main.yml"
  }

  data "local_file" "hosts" {
      filename = "./ansible/hosts.txt"
  }

  data "local_file" "ansible_config" {
      filename = "./ansible/ansible.cfg"
  }

  data "local_file" "group_vars_aws_ec2" {
      filename = "./ansible/group_vars/aws_ec2"
  }

  data "local_file" "group_vars_Ansible_app" {
      filename = "./ansible/group_vars/tag_Name_Ansible_app"
  }

  data "local_file" "group_vars_Ansible_db" {
      filename = "./ansible/group_vars/tag_Name_Ansible_db"
  }

  data "local_file" "dynamic_inventory" {
      filename = "./ansible/aws_ec2.yaml"
  }

  data "local_file" "db_script" {
      filename = "./ansible/script.sql"
  }
  #==================== App ==================================
  data "local_file" "vars_main_app" {
      filename = "./ansible/roles/deploy_app/vars/main.yml"
  }

  data "local_file" "templates_conf_apache" {
      filename = "./ansible/roles/deploy_app/templates/apache_conf.j2"
  }

  data "local_file" "defaults_main_app" {
      filename = "./ansible/roles/deploy_app/defaults/main.yml"
  }

  data "local_file" "handlers_main_app" {
      filename = "./ansible/roles/deploy_app/handlers/main.yml"
  }

  data "local_file" "meta_app" {
      filename = "./ansible/roles/deploy_app/meta/main.yml"
  }

  data "local_file" "tasks_main_app" {
      filename = "./ansible/roles/deploy_app/tasks/main.yml"
  }

  data "local_file" "playbook_app" {
      filename = "./ansible/playbook_app.yml"
  }
  #===================== DB ==================================


  data "local_file" "vars_main_db" {
      filename = "./ansible/roles/deploy_db/vars/main.yml"
  }

  data "local_file" "templates_root_db" {
      filename = "./ansible/roles/deploy_db/templates/root.cnf.j2"
  }

  data "local_file" "templates_temp_db" {
      filename = "./ansible/roles/deploy_db/templates/temp_cnf.j2"
  }

  data "local_file" "handlers_main_db" {
      filename = "./ansible/roles/deploy_db/handlers/main.yml"
  }

  data "local_file" "meta_db" {
      filename = "./ansible/roles/deploy_db/meta/main.yml"
  }

  data "local_file" "playbook_db" {
      filename = "./ansible/playbook_db.yml"
  }
########################### end data source ##############################


resource "aws_iam_role" "Ansible_dynamic_inventory" {
  name = "Ansible_dynamic_inventory"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}


data "aws_iam_policy" "admin_policy_aws" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


resource "aws_iam_role_policy_attachment" "my_attach" {
  role       = aws_iam_role.Ansible_dynamic_inventory.name
  policy_arn = data.aws_iam_policy.admin_policy_aws.arn
}


resource "aws_iam_instance_profile" "attach_role" {
  name = "My_profile"
  role = aws_iam_role.Ansible_dynamic_inventory.name
}


resource "aws_instance" "Ansible_Clients" {
  count = length(var.aws_ansible_clients)
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = var.instance_type_clients

  tags = {
    Name = element(var.aws_ansible_clients, count.index)
  }
  vpc_security_group_ids = [var.security_group_ec2_id_http, var.security_group_ec2_id_ssh, var.security_group_ec2_id_rds]

  subnet_id = var.vpc_public_subnets_b_id_ec2
  key_name  = var.key_name_instance
  iam_instance_profile = aws_iam_instance_profile.attach_role.id
}


resource "aws_instance" "Ansible_Server" {
  ami           = data.aws_ami.latest_amazon.id
  instance_type = var.instance_type_server

  tags = {
    Name = var.aws_ansible_server
  }
  vpc_security_group_ids = [var.security_group_ec2_id_http, var.security_group_ec2_id_ssh]

  subnet_id = var.vpc_public_subnets_b_id_ec2

  user_data = templatefile("./module/EC2/ansible_config.sh.tftpl", { 
    ssh_key            = var.ssh_pub_key
    ipaddr_private_app = var.private_ip_app
    ipaddr_private_db  = var.private_ip_db
    my_access_key      = var.aws_access_key
    my_secret_key      = var.aws_secret_key
    super_secret_key   = data.tls_public_key.private_key.private_key_pem
    inventory_file     = data.local_file.hosts.content
    ansible_config     = data.local_file.ansible_config.content
    aws_ec2_vars       = data.local_file.group_vars_aws_ec2.content
    app_vars           = data.local_file.group_vars_Ansible_app.content
    db_vars            = data.local_file.group_vars_Ansible_db.content
    dynamic_inventory  = data.local_file.dynamic_inventory.content
    db_script          = data.local_file.db_script.content
    defaults_main_app  = data.local_file.defaults_main_app.content
    handlers_main_app  = data.local_file.handlers_main_app.content
    config_apache      = data.local_file.templates_conf_apache.content
    vars_app           = data.local_file.vars_main_app.content

    metadata_app       = data.local_file.meta_app.content
    tasks_main_app     = data.local_file.tasks_main_app.content
    playbook_app       = data.local_file.playbook_app.content
    vars_main_db       = data.local_file.vars_main_db.content
    templates_root_db  = data.local_file.templates_root_db.content
    templates_temp_db  = data.local_file.templates_temp_db.content
    handlers_main_db   = data.local_file.handlers_main_db.content
    metadata_db        = data.local_file.meta_db.content
    tasks_db           = data.local_file.task_db.content
    playbook_db        = data.local_file.playbook_db.content
     })

  user_data_replace_on_change = true
  key_name  = var.key_name_instance
  iam_instance_profile = aws_iam_instance_profile.attach_role.id
}

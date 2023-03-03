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
    private_key_pem = "${file("./module/EC2/Ansible.pem")}"
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

  data "local_file" "group_vars_Mongo_Primary_Node" {
      filename = "./ansible/group_vars/tag_Name_Primary_Node"
  }

  data "local_file" "group_vars_Mongo_Secondary_Node" {
      filename = "./ansible/group_vars/tag_Name_Secondary_Node"
  }

  data "local_file" "dynamic_inventory" {
      filename = "./ansible/aws_ec2.yaml"
  }
  #==================== Primary Node ==================================
  /*data "local_file" "vars_main_primary_node" {
      filename = "./ansible/roles/deploy_mongo_primary_node/vars/main.yml"
  }
*/
  data "local_file" "templates_config" {
      filename = "./ansible/roles/deploy_mongo_primary_node/templates/mongo_cnf.j2"
  }

  data "local_file" "templates_mongo_service_config" {
      filename = "./ansible/roles/deploy_mongo_primary_node/templates/mongo-demo.service.j2"
  }

  data "local_file" "defaults_main_primary_node" {
      filename = "./ansible/roles/deploy_mongo_primary_node/defaults/main.yml"
  }

  data "local_file" "handlers_main_primary_node" {
      filename = "./ansible/roles/deploy_mongo_primary_node/handlers/main.yml"
  }

  data "local_file" "meta_primary_node" {
      filename = "./ansible/roles/deploy_mongo_primary_node/meta/main.yml"
  }

  data "local_file" "tasks_main_primary_node" {
      filename = "./ansible/roles/deploy_mongo_primary_node/tasks/main.yml"
  }

  data "local_file" "playbook_primary_node" {
      filename = "./ansible/playbook_primary_node.yml"
  }
  #===================== Node_2 ==================================


  data "local_file" "vars_main_secondary_node" {
      filename = "./ansible/roles/deploy_mongo_secondary_node/vars/main.yml"
  }

  data "local_file" "templates_secondary_node" {
      filename = "./ansible/roles/deploy_mongo_secondary_node/templates/mongo_cnf.j2"
  }

  data "local_file" "handlers_main_secondary_node" {
      filename = "./ansible/roles/deploy_mongo_secondary_node/handlers/main.yml"
  }

  data "local_file" "meta_secondary_node" {
      filename = "./ansible/roles/deploy_mongo_secondary_node/meta/main.yml"
  }

  data "local_file" "tasks_secondary_node" {
      filename = "./ansible/roles/deploy_mongo_secondary_node/tasks/main.yml"
  }

  data "local_file" "playbook_secondary_node" {
      filename = "./ansible/playbook_secondary_node.yml"
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


resource "aws_instance" "MongoDB_Cluster" {
  count = length(var.aws_mongodb_cluster)
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = var.instance_type_mongodb_cluster

  tags = {
    Name = element(var.aws_mongodb_cluster, count.index)
  }
  vpc_security_group_ids = [var.security_group_ec2_id_mongo_ports, var.security_group_ec2_id_ssh]

  subnet_id = var.vpc_public_subnets_b_id_ec2
  key_name  = var.key_name_instance
  iam_instance_profile = aws_iam_instance_profile.attach_role.id
}


resource "aws_instance" "Ansible_Server" {
  ami           = data.aws_ami.latest_amazon.id
  instance_type = var.instance_type_Ansible_server

  tags = {
    Name = var.aws_ansible_server
  }
  vpc_security_group_ids = [var.security_group_ec2_id_ssh]

  subnet_id = var.vpc_public_subnets_b_id_ec2

  user_data = templatefile("./module/EC2/ansible_config.sh.tftpl", { 
    ssh_key                 = var.ssh_pub_key
    ip_private_primary_node = var.private_ip_mongodb_primary_node
    ipaddr_private_sec_node = var.private_ip_mongodb_secondary_node
    public_dns_prim_node    = aws_instance.MongoDB_Cluster[0].public_dns
    public_dns_sec_node     = aws_instance.MongoDB_Cluster[1].public_dns

    my_access_key           = var.aws_access_key
    my_secret_key           = var.aws_secret_key
    super_secret_key        = data.tls_public_key.private_key.private_key_pem

    inventory_file          = data.local_file.hosts.content
    ansible_config          = data.local_file.ansible_config.content
    aws_ec2_vars            = data.local_file.group_vars_aws_ec2.content
    primary_node_vars       = data.local_file.group_vars_Mongo_Primary_Node.content
    secondary_node_vars     = data.local_file.group_vars_Mongo_Secondary_Node.content
    dynamic_inventory       = data.local_file.dynamic_inventory.content
    
    defaults_main_primary_node   = data.local_file.defaults_main_primary_node.content
    handlers_main_primary_node   = data.local_file.handlers_main_primary_node.content
    metadata_primary_node        = data.local_file.meta_primary_node.content
    config_mongo                 = data.local_file.templates_config.content
    config_mongo_service         = data.local_file.templates_mongo_service_config.content
    tasks_main_primary_node      = data.local_file.tasks_main_primary_node.content
    playbook_primary_node        = data.local_file.playbook_primary_node.content

    handlers_main_secondary_node = data.local_file.handlers_main_secondary_node.content
    vars_main_secondary_node     = data.local_file.vars_main_secondary_node.content
    config_mongo_secondary       = data.local_file.templates_secondary_node.content
    metadata_secondary_node      = data.local_file.meta_secondary_node.content
    tasks_secondary_node         = data.local_file.tasks_secondary_node.content
    playbook_secondary_node      = data.local_file.playbook_secondary_node.content
     })

  user_data_replace_on_change = true
  key_name  = var.key_name_instance
  iam_instance_profile = aws_iam_instance_profile.attach_role.id
}

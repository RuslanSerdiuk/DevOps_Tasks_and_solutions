############################
# Tags                     #
############################
backend_role          = "terraform_windows"
finance_product       = "neogames"
finance_env           = "prod"
name_env              = "pd"

############################
# Key-Pair                 #
############################
key_name = "windows-key-pair" 

############################
# Network                  #
############################
vpc_cidr            = "10.11.0.0/16"
public_subnet_cidr  = "10.11.1.0/24"
security_group_name = "windows-sg"

############################
# EC2 - Windows            #
############################
windows_instance_name               = "windows_vm"
windows_instance_type               = "t2.micro"
windows_associate_public_ip_address = true
windows_root_volume_size            = 30
windows_root_volume_type            = "gp2"
windows_data_volume_size            = 10
windows_data_volume_type            = "gp2"

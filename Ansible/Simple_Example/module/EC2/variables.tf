variable "vpc_public_subnets_b_id_ec2" {
    description = "ID_of_Public_Subnet_B_for_your_Instances"
}

variable "security_group_ec2_id_http" {
    description = "ID_of_HTTP_and_HTTPS_Security_Group"
}

variable "security_group_ec2_id_ssh" {
    description = "ID_of_SSH_Security_Group"
}

variable "security_group_ec2_id_rds" {
    description = "ID_of_RDS_Security_Group"
}

variable "aws_ansible_clients" {
    description = "Several_Clients_for_Ansible"
    default     = ["Instance_1", "Instance_2"]
}

variable "aws_ansible_server" {
    description = "Main_Ansible_Server"
    default     = "Main_Instance"
}

variable "instance_type_server" {
    description = "Type_your_Instance_for_Main_Server"
    default     = "t2.micro"
}

variable "instance_type_clients" {
    description = "Type_your_Instances_for_several_Clients"
    default     = "t2.micro"
}

variable "private_ip_app" {
    description = "Privat_IP_of_Application_Instance"
}

variable "private_ip_db" {
    description = "Privat_IP_of_Database_Instance"
}

variable "key_name_instance" {
    description = "Key_for_your_Instance"
    default     = "Ruslan-key-Ohio-TASK2.2"
}

variable "aws_access_key" {
    description = "AWS_Access_Key"
}

variable "aws_secret_key" {
    description = "AWS_SECRET_Key"
}

variable "ssh_pub_key" {
    description = "key_for_ssh_connect"
    default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC31w4H26HYD/iEPSnzy1uSBCyY+ZlAWVMS1ZLkh9qTDP9Yi7ZmzGeuqys7NPWa+KBoSwCqWAVUYxGR5ul26vPHJGJwdjMvuYiDArhdetfbiMljnG0SxOuqApZxVJNuCYH6Q7XUe2oh4FsWSDiFZFnA+0sum/kFwstc10OfRYMJtXqKhN24UcwimjOIQN/tIip2lRyI5f+CefvrLBm7J9HC8GT6GDYrTdiCiD6FjtSleL2lYMDsHM70RtvRDfkrCrv45qG+v3UYmxlYmyDLgeJGs739j4YEXGBWL3bRP2+T+y3p1gFYVCwtzSMwwE4HqrGl9gfn/Z2W0LZTEwLSXyNnMf9Y2+oBLSkV6mThTlrCK47pXeBC07cdYMhpSm/o4hTRe5qkD3ye4kJ16BBRIeYlKeNdZ2Tw+w1hVOjE+duM4+YwXuG6/sh7AgT3pZykjl8ZtCl3QTLmWz1Ug3fB6M5f71ek6igdctdn528gNW+3R4Fmab2AljWF8cL1XWYsGxE= epam\ruslan_serdiuk@EPUAKHAW07C2"
}
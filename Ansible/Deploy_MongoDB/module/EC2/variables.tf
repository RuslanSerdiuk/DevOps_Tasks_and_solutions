variable "vpc_public_subnets_b_id_ec2" {
    description = "ID of Public Subnet_B for your Instances"
}

variable "security_group_ec2_id_mongo_ports" {
    description = "ID of MongoDB SG"
}

variable "security_group_ec2_id_ssh" {
    description = "ID of Ansible and MongoDB SSH Connection SG"
}

variable "aws_mongodb_cluster" {
    description = "MongoDB Cluster"
    default     = ["Instance_1", "Instance_2"]
}

variable "aws_ansible_server" {
    description = "Ansible Server"
    default     = "Ansible_Server"
}

variable "instance_type_Ansible_server" {
    description = "Type Instance for Ansible Server"
    default     = "t2.micro"
}

variable "instance_type_mongodb_cluster" {
    description = "Type Instances for MongoDB Cluster"
    default     = "t2.micro"
}

variable "private_ip_mongodb_primary_node" {
    description = "Privat IP of Primary Node"
}

variable "private_ip_mongodb_secondary_node" {
    description = "Privat IP of Secondary Node"
}

variable "key_name_instance" {
    description = "Key for your Instance"
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
output "Ansible_Server_public_DNS" {
  description = "MongoDB Primary NODE Public DNS"
  value       = module.ec2.aws_ansible_server_public_dns
}

# output "MongoDB_Cluster_public_ip" {
#   description = "Ansible Clients Public DNS"
#   value = module.ec2.aws_mongodb_Cluster_public_ip
# }

output "MongoDB_Primary_Node_public_DNS" {
  description = "MongoDB Primary Node Public DNS"
  value       = module.ec2.aws_mongodb_primary_node_public_dns
}

output "MongoDB_Secondary_Node_public_DNS" {
  description = "MongoDB Secondary Node Public DNS"
  value       = module.ec2.aws_mongodb_secondary_node_public_dns
}

output "MongoDB_Primary_Node_Privat_IP" {
  value       = module.ec2.mongogb_primary_node_private_ip
}

output "MongoDB_Secondary_Node_Privat_IP" {
  value       = module.ec2.mongogb_secondary_node_private_ip
}
output "Ansible_SERVER_public_DNS" {
  description = "Ansible Server Public DNS"
  value       = module.ec2.aws_ansible_server_public_dns
}

# output "Ansible_Clients_public_IP" {
#   description = "Ansible Clients Public DNS"
#   value = module.ec2.aws_ansible_clients_public_ip
# }

output "Client_APP_public_DNS_CHECK_RESULT_HERE" {
  description = "Ansible Server Public DNS"
  value       = module.ec2.aws_ansible_client_app_public_dns
}

output "Client_DB_public_DNS" {
  description = "Ansible Server Public DNS"
  value       = module.ec2.aws_ansible_client_db_public_dns
}

output "Client_app_Privat_IP" {
  value       = module.ec2.ec2_private_ip_app
}

output "Client_db_Privat_IP" {
  value       = module.ec2.ec2_private_ip_db
}
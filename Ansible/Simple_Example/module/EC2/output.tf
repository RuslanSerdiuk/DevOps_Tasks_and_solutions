output "aws_ansible_server_public_dns" {
  description = "Ansible Server Public DNS"
  value       = aws_instance.Ansible_Server.public_dns
}

output "aws_ansible_client_app_public_dns" {
  description = "Ansible Server Public DNS"
  value       = aws_instance.Ansible_Clients[0].public_dns
}

output "aws_ansible_client_db_public_dns" {
  description = "Ansible Server Public DNS"
  value       = aws_instance.Ansible_Clients[1].public_dns
}

output "aws_ansible_clients_public_ip" {
  description = "Ansible Clients Public IP"
  value = [
    for instance in aws_instance.Ansible_Clients :
    "Client: ${instance.instance_state} has IP: ${instance.public_ip}"
  ]
}

output "ec2_private_ip_app" {
  value     = aws_instance.Ansible_Clients[0].private_ip
}

output "ec2_private_ip_db" {
  value     = aws_instance.Ansible_Clients[1].private_ip
}

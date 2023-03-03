output "TF_Ansible_id" {
  description = "TF_Ansible_id"
  value       = aws_security_group.TF_Ansible.id
}

output "SSH_Connection_id" {
  description = "SSH_Connection_id"
  value       = aws_security_group.TF_Ansible_SSH_Connection.id
}

output "TF_Ansible_DB_id" {
  description = "TF_Ansible_RDS"
  value       = aws_security_group.TF_Ansible_DB.id
}
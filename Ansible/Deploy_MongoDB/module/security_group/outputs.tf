output "MongoDB_Ports_id" {
  description = "SG MongoDB Connection id"
  value       = aws_security_group.TF_MongoDB_Ports.id
}

output "SSH_Connection_id" {
  description = "SG MongoDB_SSH Connection id"
  value       = aws_security_group.TF_Ansible_Mongo_SSH_Connection.id
}

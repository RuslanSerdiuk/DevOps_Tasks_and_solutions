output "TF_Bastion_id" {
  description = "TF_SSH_Bastion_id"
  value = aws_security_group.TF_Bastion.id
}

output "SSH_Connection_id" {
  description = "SSH_Connection_id"
  value = aws_security_group.TF_SSH_Connection.id
}

output "TF_EPAM_RDS_id" {
  description = "TF_EPAM_RDS_id"
  value = aws_security_group.TF_EPAM_RDS.id
}
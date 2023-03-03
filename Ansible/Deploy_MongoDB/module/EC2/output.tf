output "aws_ansible_server_public_dns" {
  description = "MongoDB Primary NODE Public DNS"
  value       = aws_instance.Ansible_Server.public_dns
}

output "aws_mongodb_primary_node_public_dns" {
  description = "MongoDB Primary Node Public DNS"
  value       = aws_instance.MongoDB_Cluster[0].public_dns
}

output "aws_mongodb_secondary_node_public_dns" {
  description = "MongoDB Secondary Node Public DNS"
  value       = aws_instance.MongoDB_Cluster[1].public_dns
}

output "aws_mongodb_Cluster_public_ip" {
  description = "MongoDB Cluster Public IP"
  value = [
    for instance in aws_instance.MongoDB_Cluster :
    "Client: ${instance.instance_state} has IP: ${instance.public_ip}"
  ]
}

output "mongogb_primary_node_private_ip" {
  value     = aws_instance.MongoDB_Cluster[0].private_ip
}

output "mongogb_secondary_node_private_ip" {
  value     = aws_instance.MongoDB_Cluster[1].private_ip
}

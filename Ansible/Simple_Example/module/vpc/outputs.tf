output "vpc_id" {
  description = "The_ID_of_the_VPC"
  value       = aws_vpc.TF_Ansible.id
}

output "public_subnets_a" {
  description = "Public_Subnet_A_ID"
  value       = aws_subnet.TF_Ansible_Public_Subnet_A.id
}

output "public_subnets_b" {
  description = "Public_Subnet_B_ID"
  value       = aws_subnet.TF_Ansible_Public_Subnet_B.id
}

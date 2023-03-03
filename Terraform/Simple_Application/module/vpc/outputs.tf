output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.TF_EPAM.id
}

output "private_subnets_a" {
  description = "Privat Subnet-A ID"
  value       = aws_subnet.TF_EPAM_Privat_Subnet_A.id
}

output "private_subnets_b" {
  description = "Privat Subnet-B ID"
  value       = aws_subnet.TF_EPAM_Privat_Subnet_B.id
}

output "public_subnets_a" {
  description = "Public Subnet-A ID"
  value       = aws_subnet.TF_EPAM_Public_Subnet_A.id
}

output "public_subnets_b" {
  description = "Public Subnet-B ID"
  value       = aws_subnet.TF_EPAM_Public_Subnet_B.id
}
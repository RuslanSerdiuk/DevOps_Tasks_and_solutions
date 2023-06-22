output "windows_server_public_ip" {
  description = "Windows Host Public DNS"
  value = aws_instance.windows_server.public_dns
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

output "public_subnets_b" {
  description = "Public Subnet ID"
  value       = aws_subnet.public_subnet.id
}
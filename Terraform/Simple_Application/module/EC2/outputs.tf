output "aws_instance_public_ip" {
  description = "Bastion Host Public DNS"
  value = aws_instance.Bastion_Host.public_dns
}
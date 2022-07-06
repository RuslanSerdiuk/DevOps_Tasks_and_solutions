output "TF_Balancer_dns_name" {
  description = "TF-Balancer_dns_name"
  value       = aws_lb.TF_Balancer.dns_name
}

output "TF_Balancer_zone_id" {
  description = "TF-Balancer_zone_id"
  value       = aws_lb.TF_Balancer.zone_id
}
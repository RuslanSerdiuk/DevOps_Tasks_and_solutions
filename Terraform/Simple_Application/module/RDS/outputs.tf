output "RDS_Endpoint" {
  description = "RDS Endpoint"
  value = aws_db_instance.database.address
}

output "database_name" {
  value = aws_db_instance.database.name
}

output "username" {
  value = aws_db_instance.database.username
}

output "password" {
  value = aws_db_instance.database.password
}